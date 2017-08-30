class PatentDetailExtractor
  attr_accessor :documents

  US_COUNTRY_CODE = 'US'
  CORE_ASSET_SOURCE = 'C'
  DOCDB_ASSET_SOURCE = 'D'
  MANUAL_ASSET_SOURCE = 'M'
  PATENT_REGEX = /([A-Z]{2,})?([0-9\-]{4,})/
  IMPORT_RECORDS_LIMIT = 250

  MANUAL_SEARCHING_LEVELS = [:patent_number, :publication_number, :application_number].map do |column_name|
    {klass: ManualAsset, country_code: US_COUNTRY_CODE, column_name: column_name, asset_source: MANUAL_ASSET_SOURCE}
  end

  CORE_SEARCHING_LEVELS = [:stripped_patnum, :app_num_country].map do |column_name|
    {klass: CorePat, country_code: US_COUNTRY_CODE, column_name: column_name, asset_source: CORE_ASSET_SOURCE}
  end + MANUAL_SEARCHING_LEVELS


  DOCDB_SEARCHING_LEVELS = [:stripped_patnum, :app_num_intl].map do |column_name|
    {klass: DocdbPat, column_name: column_name, asset_source: DOCDB_ASSET_SOURCE}
  end + MANUAL_SEARCHING_LEVELS.map{ |searching_level| searching_level.except(:country_code) }

  def initialize(documents = [])
    @documents = documents
  end

  def extract!
    patents = []

    documents.each do |document|
      ocr_text = document.ocr_text
      if ocr_text.blank?
        ocr_content = DocsplitProcessor.new(document.file.path).process
        ocr_text = ocr_content[:ocr_text]
        document.update_attributes(ocr_text: ocr_text)
      end
      patnums = ocr_text.scan(PATENT_REGEX)
      partitioned_patnums = {us_patnums: [], non_us_patnums: [], patnums_without_cc: []}
      patnums.inject(partitioned_patnums) do |partitioned_collection, patnum|
        country_code = patnum[0]

        if country_code.present?
          actual_collection = country_code == US_COUNTRY_CODE ? partitioned_collection[:us_patnums] : partitioned_collection[:non_us_patnums]
          actual_collection.push(patnum)
        else
          partitioned_collection[:patnums_without_cc].push(patnum)
        end
        partitioned_collection
      end
      us_patents = fetch_patents(partitioned_patnums[:us_patnums], CORE_SEARCHING_LEVELS, true)
      non_us_patents = fetch_patents(partitioned_patnums[:non_us_patnums], DOCDB_SEARCHING_LEVELS, true)
      us_patents_without_cc = fetch_patents(partitioned_patnums[:patnums_without_cc], CORE_SEARCHING_LEVELS, false)
      non_us_patents_without_cc = fetch_patents(partitioned_patnums[:patnums_without_cc], DOCDB_SEARCHING_LEVELS, false)
      consolidated_patents = us_patents + non_us_patents + us_patents_without_cc + non_us_patents_without_cc

      consolidated_patents.each_slice(IMPORT_RECORDS_LIMIT) do |patent_slice|
        pat_slice = patent_slice.map{ |slice| slice.merge(document_id: document.id) }
        Patent.import(pat_slice)
      end
      document.completed!
      patents << {
        document_name: document.file.filename,
        patents: consolidated_patents
      }
    end
    patents
  end

  private

  def fetch_patents(patent_numbers = [], searching_levels, with_country_code)
    cached_pat_nums = patent_numbers.map{ |pat_num| "#{pat_num[0]}#{pat_num[1]}" }.uniq
    country_codes, pat_nums = patnums_and_country_codes(cached_pat_nums)
    patents = []

    searching_levels.each do |searching_level|
      break if cached_pat_nums.blank?
      pats = fetch_pats_by(pat_nums, country_codes, searching_level)
      cached_patnums = []
      pats =
      pats.select do |pat|
        cached_patnum = with_country_code ? "#{pat.country_code}#{pat[searching_level[:column_name]]}" : pat[searching_level[:column_name]]
        cached_patnums << cached_patnum
        cached_pat_nums.include?(cached_patnum)
      end
      patents << pats.map do |pat|
        {patnum: pat.patnum, asset_source: searching_level[:asset_source],
         asset_source_id: pat.id, matched_with_country_code: with_country_code}
      end
      cached_pat_nums = cached_pat_nums - cached_patnums
      country_codes, pat_nums = patnums_and_country_codes(cached_pat_nums)
    end
    patents.flatten
  end

  def fetch_pats_by(patent_numbers, country_codes, search_source_opts = {})
    klass = search_source_opts[:klass]
    column_name = search_source_opts[:column_name]
    country_code = search_source_opts[:country_code]
    country_column = klass == ManualAsset ? 'country' : 'country_code'

    country_code_search_str =
    if country_code.present?
      ["#{country_column} = ?", US_COUNTRY_CODE]
    else
      country_codes.compact.blank? ? ["#{country_column} != (?)", US_COUNTRY_CODE] : ["#{country_column} IN (?)", country_codes]
    end
    klass.where(column_name => patent_numbers).where(country_code_search_str).select(:id, :patnum, country_column.to_sym, column_name)
  end

  def patnums_and_country_codes(cached_patnums = [])
    patent_numbers = cached_patnums.map { |cached_patnum| cached_patnum.scan(PATENT_REGEX).flatten }
    [patent_numbers.map(&:first).compact.uniq,  patent_numbers.map(&:last).uniq]
  end
end
