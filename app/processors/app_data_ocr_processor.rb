class AppDataOcrProcessor < OcrProcessorBase
  FREQUENCY = '3m'
  OCR_LIMIT = 50

  def process!
    pair_ocrs = PairOcr.ocrable_documents.limit(OCR_LIMIT)

    pair_ocrs.each do |pair_ocr|
      begin
        app_s3_path = pair_ocr.app_s3_path.split('/')[-1]
        zip_name = app_s3_path.gsub('.zip', '')
        ocr_s3_path = "#{zip_name}-ocr.zip"

        pdf_zip = S3Downloader.new({s3_key: pair_ocr.app_s3_path.split('/')[-1], bucket: ENV['PAIR_BUCKET']}).download
        ocr_zip = S3Downloader.new({s3_key: pair_ocr.ocr_s3_path.split('/')[-1], bucket: ENV['PAIR_BUCKET']}).download if pair_ocr.ocr_s3_path.present?
        zip_utility = ZipUtility.new(pdf_zip.path, ocr_zip.try(:path), zip_name)

        # OCR the new pdfs
        zip_utility.ocrable_pdfs.each { |pdf_file| process_ocr(pdf_file, zip_utility) }
        ocred_zip_dir = zip_utility.generate_ocr_zip

        # Update OCR ZIP to S3
        s3_uploader = S3Uploader.new({}).save_file_to_s3(ocr_s3_path, ocred_zip_dir, {bucket_name: ENV['PAIR_BUCKET']})
        pair_ocr.update_attributes(ocr_s3_path: "#{ENV['PAIR_BUCKET']}/#{ocr_s3_path}", needs_ocr: false, ocred_at: Time.now)
      rescue => exception
        pair_ocr.update_attributes(needs_ocr: true)
        Honeybadger.notify(exception, context: {pair_ocr_id: pair_ocr.id, document_type: PairOcr})
      ensure
        zip_utility.clear_tmp_files if zip_utility.present?
        FileUtils.rm(pdf_zip.path) if pdf_zip.present?
        FileUtils.rm(ocr_zip.path) if ocr_zip.present?
      end
      Rails.logger.info("Completed the OCR for the app data document: '#{pair_ocr.app_s3_path}' and the OCR zip s3 path is '#{pair_ocr.ocr_s3_path}'")
      Rails.logger.info("Proceeding to process next app data document")
    end
  end

  def process_ocr(pdf_file, zip_utility)
    pdf_file_name = pdf_file.split('/')[-1]
    ocr_file_name = pdf_file_name.gsub('.pdf', '.txt')

    # Save the OCRed PDF text to .txt file
    ocr_content = DocsplitProcessor.new(pdf_file, {psm: 3}).process
    zip_utility.add_ocred_file(ocr_file_name, ocr_content[:ocr_text])
  end
end
