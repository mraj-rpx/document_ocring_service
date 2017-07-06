class PatentDetailExtractor
  attr_accessor :documents

  US_COUNTRY_CODE = 'US'
  CORE_ASSERT_SOURCE = 'C'
  DOCDB_ASSERT_SOURCE = 'D'

  def initialize(documents = [])
    @documents = documents
  end

  def patent_details
    patents = []

    documents.each do |document|
      ocr_content = DocsplitProcessor.new(document.path).process
      patnums = ocr_content[:ocr_text].scan(/([A-Z]{2,})?([0-9\-]{4,})/)
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
      us_patents = fetch_patents(partitioned_patnums[:us_patnums], true, true)
      non_us_patents = fetch_patents(partitioned_patnums[:non_us_patnums], false, true)

      us_patents_without_cc = fetch_patents(partitioned_patnums[:patnums_without_cc], true, false)
      non_us_patents_without_cc = fetch_patents(partitioned_patnums[:patnums_without_cc], false, false)

      patents << {
        document_name: document.original_filename,
        patents_with_country_code: { us_patents: us_patents, non_us_patents: non_us_patents },
        patents_without_country_code: { us_patents: us_patents_without_cc, non_us_patents: non_us_patents_without_cc }
      }
    end
    patents
  end

  private

  def fetch_patents(patent_numbers = [], is_us_patents, with_country_code)
    pats, asset_source =
    if is_us_patents
      [fetch_us_patents(patent_numbers), CORE_ASSERT_SOURCE]
    else
      [fetch_non_us_patents(patent_numbers, with_country_code), DOCDB_ASSERT_SOURCE]
    end

    pats.map do |pat|
      {patnum: pat.patnum, asset_source: asset_source, asset_source_id: pat.id}
    end
  end

  def fetch_us_patents(patent_numbers = [])
    CorePat.where(stripped_patnum: patent_numbers.map(&:last)).select(:id, :patnum)
  end

  def fetch_non_us_patents(patent_numbers = [], with_country_code)
    stripped_patnums = patent_numbers.map(&:last)

    pats =
    if with_country_code
      country_codes = patent_numbers.map(&:first)
      cached_patent_numbers = patent_numbers.map{ |patnum| "#{patnum[0]}#{patnum[1]}" }
      cached_pats = DocdbPat.where(stripped_patnum: stripped_patnums, country_code: country_codes).select(:id, :patnum)
      cached_pats.select{ |pat| cached_patent_numbers.include?("#{pat.country_code}#{pat.stripped_patnum}") }
    else
      DocdbPat.where('stripped_patnum in (?) AND country_code != ?', stripped_patnums, US_COUNTRY_CODE).select(:id, :patnum)
    end
    pats
  end
end
