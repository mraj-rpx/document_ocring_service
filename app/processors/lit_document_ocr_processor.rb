class LitDocumentOcrProcessor < OcrProcessorBase
  FREQUENCY = '2m'

  def process!
    documents = LitDocument.ocrable_docs.limit(LIMIT)

    documents.each do |document|
      begin
        path = S3Downloader.new({s3_key: document.rpx_file_name, bucket: ENV['LIT_DOC_BUCKET']}).download
        ocr_content = DocsplitProcessor.new(path).process
        document.update_attributes(ocr_text: ocr_content[:ocr_text], ocr_exception: nil, needs_ocr: false)
      rescue => exception
        document.update_attributes(ocr_exception: exception)
        Rails.logger.error(exception)
      end
    end
  end
end
