class PtabOcrProcessor
  LIMIT = 5
  FREQUENCY = '2m'

  def process!
    documents = PtabCaseDetail.ocrable_docs.limit(LIMIT)

    documents.each do |document|
      begin
        s3_key = document.document_path.gsub(/^rpx-ptab\//, '')
        path = S3Downloader.new({s3_key: s3_key, bucket: ENV['PTAB_BUCKET']}).download
        ocr_content = DocsplitProcessor.new(path).process

        document.update_attributes(ocr_text: ocr_content[:ocr_text], needs_ocr: false)
      rescue => exception
        # document.update_attributes(exception: exception)
        Rails.logger.error(exception)
      end
    end
  end
end
