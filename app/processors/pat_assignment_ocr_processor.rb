class PatAssignmentOcrProcessor < OcrProcessorBase
  FREQUENCY = '3m'

  def process!
    assignments = PatAssignmentAttachment.ocrable_assignments.limit(LIMIT)

    assignments.each do |assignment|
      begin
        s3_pdf_url = assignment.s3_pdf_url.gsub('s3://rpx-docs/', '').gsub('//', '/')
        s3_downloader = S3Downloader.new({s3_key: s3_pdf_url, bucket: ENV['LIT_DOC_BUCKET']})
        tempfile = s3_downloader.download

        ocr_content = DocsplitProcessor.new(tempfile.path, {psm: 11}).process
        ocr_text_s3_key = assignment.s3_ocr_url.present? ? assignment.s3_ocr_url : "pat-assignments/#{SecureRandom.hex(3)}/#{assignment.assignment_id}.txt"
        S3Uploader.new(ocr_content[:ocr_text]).save_to_s3(ocr_text_s3_key)
        assignment.update_attributes(s3_ocr_url: ocr_text_s3_key, ocr_exception: nil, parsing_exception: nil)
      rescue => exception
        assignment.update_attributes(ocr_exception: exception)
        Honeybadger.notify(exception, context: {document_id: assignment.id, document_type: PatAssignmentAttachment})
      end
    end
  end
end
