class PatAssignmentMetadataProcessor < OcrProcessorBase
  FREQUENCY = '3m'

  def process!
    assignments = PatAssignmentAttachment.parsable_assignments.limit(LIMIT)

    assignments.each do |assignment|
      begin
        path = S3Downloader.new({s3_key: assignment.s3_ocr_url, bucket: ENV['AWS_OCR_BUCKET']}).download
        pats_metadata = PatAssignmentMetadataExtractor.new(File.read(path)).extract!
        assignment.update_attributes(pats_metadata.merge(parsing_exception: nil, is_parsed: true))
      rescue => exception
        assignment.update_attributes(parsing_exception: exception)
        Rails.logger.error(exception)
      end
    end
  end
end
