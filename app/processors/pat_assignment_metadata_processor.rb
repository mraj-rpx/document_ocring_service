class PatAssignmentMetadataProcessor < OcrProcessorBase
  FREQUENCY = '3m'

  def process!
    assignments = PatAssignmentAttachment.parsable_assignments.limit(LIMIT)

    assignments.each do |assignment|
      begin
        s3_downloader = S3Downloader.new({s3_key: s3_ocr_url, bucket: ENV['AWS_OCR_BUCKET']})
        tempfile = s3_downloader.download

        pats_metadata = PatAssignmentMetadataExtractor.new(File.read(tempfile.path)).extract!
        assignment.update_attributes(pats_metadata.merge(parsing_exception: nil, is_parsed: true))
      rescue => exception
        assignment.update_attributes(parsing_exception: exception)
        Honeybadger.notify(exception, context: {document_id: assignment.id, document_type: PatAssignmentAttachment})
      end
    end
  end
end
