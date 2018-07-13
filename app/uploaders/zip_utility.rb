class ZipUtility
  def initialize(pdf_zip, ocr_zip, zip_name)
    @pdf_zip = pdf_zip
    @ocr_zip = ocr_zip
    @zip_name = zip_name
    @dest_dir = "#{Rails.root}/tmp/#{SecureRandom.hex(4)}"
    @pdf_dir = "#{@dest_dir}/#{@zip_name}"
    @ocr_dir = "#{@pdf_dir}-ocr"
  end

  def ocrable_pdfs
    FileUtils.rm_rf(@dest_dir)
    IO.popen(["unzip", @pdf_zip, "-d", @dest_dir]).readlines
    pdfs = Dir.glob("#{@pdf_dir}/#{@zip_name}-image_file_wrapper/*.pdf")

    ocrs =
    if @ocr_zip.present?
      IO.popen(["unzip", @ocr_zip, "-d", @dest_dir]).readlines
      Dir.glob("#{@ocr_dir}/*.txt")
    else
      FileUtils.mkdir_p(@ocr_dir)
      []
    end
    ocr_file_names = ocrs.map{ |ocr| ocr.split('/')[-1].gsub('.txt', '') }
    pdfs.reject{ |pdf| ocr_file_names.include?(pdf.split('/')[-1].gsub('.pdf', '')) }
  end

  def add_ocred_file(ocr_file_name, ocr_text)
    File.open("#{@ocr_dir}/#{ocr_file_name}", "w+"){ |f| f.write(ocr_text) }
  end

  def generate_ocr_zip
    ocr_zip_file = "#{@zip_name}-ocr.zip"
    FileUtils.rm_rf(ocr_zip_file)

    IO.popen("cd #{@dest_dir}; zip -r #{ocr_zip_file} #{@zip_name}-ocr").readlines
    "#{@dest_dir}/#{ocr_zip_file}"
  end

  def clear_tmp_files
    FileUtils.rm_rf(@dest_dir)
  end
end
