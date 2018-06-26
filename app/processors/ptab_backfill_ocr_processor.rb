class PtabBackfillOcrProcessor < OcrProcessorBase
  BACKFILL_LIMIT = 25

  def process!
    documents = PtabCaseDetail.ocrable_docs_for_backfill.limit(BACKFILL_LIMIT)

    documents.each do |document|
      begin
        s3_key = document.document_path.gsub(/^rpx-ptab\//, '')
        tempfile = S3Downloader.new({s3_key: s3_key, bucket: ENV['PTAB_BUCKET']}).download

        ocr_content = DocsplitProcessor.new(tempfile.path).process
        ocr_text_s3_key = s3_key.gsub(File.extname(s3_key), '.txt')
        S3Uploader.new(ocr_content[:ocr_text]).save_to_s3(ocr_text_s3_key, {bucket_name: ENV['PTAB_BUCKET']})
        document.update_attributes(ocr_text: ocr_content[:ocr_text], ocr_exception: nil, needs_ocr: false, ocr_text_s3_path: "#{ENV['PTAB_BUCKET']}/#{ocr_text_s3_key}")
      rescue => exception
        document.update_attributes(ocr_exception: exception)
        Honeybadger.notify(exception, context: {document_id: document.id, document_type: PtabCaseDetail})
      end
    end
  end
end
