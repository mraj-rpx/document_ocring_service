class OcrProcessorBase
  LIMIT = 5

  def lit_doc_ocr(document, options = {})
    begin
      s3_downloader = S3Downloader.new({s3_key: document.rpx_file_name, bucket: document.rpx_file_location})
      tempfile = s3_downloader.download

      ocr_content = DocsplitProcessor.new(tempfile.path).process
      ocr_text_s3_key = document.ocr_text_s3_path || "lit-documents/#{SecureRandom.hex(3)}/#{document.id}.txt"
      S3Uploader.new(ocr_content[:ocr_text]).save_to_s3(ocr_text_s3_key)

      attrs = {ocr_text_s3_path: ocr_text_s3_key, ocr_exception: nil, ocred_at: Time.now, needs_ocr: false}
      attrs.merge!({ocr_text: ocr_content[:ocr_text]}) if options[:save_ocr_text_to_db]
      document.update_attributes(attrs)
    rescue => exception
      document.update_attributes(ocr_exception: exception)
      Honeybadger.notify(exception, context: {document_id: document.id, document_type: LitDocument})
    end
  end
end
