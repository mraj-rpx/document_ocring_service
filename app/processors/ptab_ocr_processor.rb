class PtabOcrProcessor < OcrProcessorBase
  FREQUENCY = '2m'

  def process!
    documents = PtabCaseDetail.ocrable_docs.limit(LIMIT)

    documents.each do |document|
      begin
        s3_key = document.document_path.gsub(/^rpx-ptab\//, '')
        tempfile = S3Downloader.new({s3_key: s3_key, bucket: ENV['PTAB_BUCKET']}).download

        ocr_content = DocsplitProcessor.new(tempfile.path).process
        ocr_text_s3_key = "ptab/#{SecureRandom.hex(3)}/#{document.id}.txt"
        S3Uploader.new(ocr_content[:ocr_text]).save_to_s3(ocr_text_s3_key)

        document.update_attributes(ocr_text: ocr_content[:ocr_text], ocr_exception: nil,
                                   needs_ocr: false, ocr_text_s3_path: ocr_text_s3_key)
      rescue => exception
        document.update_attributes(ocr_exception: exception)
        Honeybadger.notify(exception, context: {document_id: document.id, document_type: PtabCaseDetail})
      end
    end
  end
end
