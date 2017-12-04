class PatAssignmentMetadataExtractor
  METADATA_REGEXP = {
    correspondent_phone: /phone:/i,
    correspondent_email: /email:/i,
    correspondent_name: /correspondent name:/i,
    correspondent_address_line_1: /address line 1:/i,
    correspondent_address_line_2: /address line 2:/i,
    correspondent_address_line_3: /address line 3:/i,
    correspondent_address_line_4: /address line 4:/i,
    submitter_name: /name of submitter:/i,
    submitter_signature: /signature:/i,
    submitter_date_signed: /date signed:/i
  }

  def initialize(ocr_text)
    @metadata_section = collect_metadata_section_fields(ocr_text)
    @metadata = {}
  end

  def extract!
    METADATA_REGEXP.each do |name, regexp|
      @metadata[name] = extract_field(name, regexp)
    end
    @metadata
  end

  private

  def extract_field(name, regexp)
    match_data = @metadata_section.find{ |data| data.match(regexp) }
    return if match_data.blank?
    start_index = @metadata_section.index(match_data) + 1
    field_value = []

    @metadata_section[start_index..-1].each do |value|
      break if value[-1] == ':'
      field_value << value
    end
    field_value = field_value.join('\n')

    if name == :submitter_date_signed
      matcher = field_value.match(/(\d{1,2})\/(\d{1,2})\/([0-9\s]{4,})/)
      field_value = Date.parse("#{matcher[2]}/#{matcher[1]}/#{matcher[3].gsub(/\s/, '')}")
    end

    field_value.gsub!(/\s/, '') if name == :correspondent_email
    field_value.gsub!(/[^0-9]/, '') if name == :correspondent_phone
    field_value
  end

  def collect_metadata_section_fields(ocr_text)
    metadata_start = ocr_text =~ /correspondence data/i
    metadata_end = ocr_text =~ /total attachments:/i
    meta_section = ocr_text[metadata_start...metadata_end].lines.map(&:strip).reject{ |line| line.blank? }

    correspon_name = meta_section.find{ |data| data.match(METADATA_REGEXP[:correspondent_name]) }
    index = meta_section.index(correspon_name)

    if meta_section[index + 1][-1] == ':'
      name = meta_section.delete_at(index - 1)
      meta_section.insert(index, name)
    end
    meta_section
  end
end
