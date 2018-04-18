class DocsplitProcessor < Docsplit::TextExtractor

  SCANNED_PDF = 'scanned_pdf'
  PLAIN_PDF = 'plain_pdf'

  def initialize(pdf, ocr_options = {})
    @pdf = Docsplit.ensure_pdfs(pdf)[0]
    @pages = 'all'
    @output = Rails.root.join("tmp/TESSERACT/#{SecureRandom.uuid}")
    @total_pages = Docsplit.extract_length(@pdf)
    @pdf_name = File.basename(@pdf, File.extname(@pdf))
    @tempdir = Rails.root.join("tmp/TESSERACT/#{SecureRandom.uuid}")
    @pages_to_ocr = []
    @ocr_options = ocr_options
  end

  def process
    FileUtils.mkdir_p @output unless File.exists?(@output)
    FileUtils.mkdir_p @tempdir unless File.exists?(@tempdir)

    extract_from_pdf(@pdf, 1..@total_pages)
    process_scanned_pages if @pages_to_ocr.present?

    {ocr_text: read_all_pages_content, pdf_type: @pages_to_ocr.present? ? SCANNED_PDF : PLAIN_PDF}
  ensure
    FileUtils.remove_entry_secure(@output) if File.exists?(@output)
    FileUtils.remove_entry_secure(@tempdir) if File.exists?(@tempdir)
  end

  private

  def read_all_pages_content
    content = ''

    (1..@total_pages).each do |index|
      content << File.read("#{File.join(@output, @pdf_name)}_#{index}.txt")
    end
    content
  end

  def process_scanned_pages
    tiff_file_base_path = Docsplit::ESCAPE[File.join(@tempdir, @pdf_name)]
    text_file_base_path = Docsplit::ESCAPE[File.join(@output, @pdf_name)]

    convert_pages_to_tiff_image(tiff_file_base_path)
    extract_text_from_tiff_images(tiff_file_base_path, text_file_base_path)
  end

  def convert_pages_to_tiff_image(base_path)
    options = "-despeckle +adjoin -limit memory 256Mib -limit map 512Mib -density 300 -colorspace GRAY"
    run("parallel -j#{ENV['TOTAL_CONCURRENT_JOBS_FOR_OCR'].to_i} gm convert #{options} '#{Docsplit::ESCAPE[@pdf]}\\[$(({} - 1))\\]' -quality 100 '#{base_path}_{}.tif' 2>&1 ::: #{@pages_to_ocr.join(' ')}")
  rescue => exception
    raise exception unless exception.message =~ /pagesize/i
    handle_large_page_size(base_path)
  end

  def extract_text_from_tiff_images(tiff_file_base_path, text_file_base_path)
    options = "-l eng -psm #{@ocr_options[:psm] || 11}"

    run("parallel -j#{ENV['TOTAL_CONCURRENT_JOBS_FOR_OCR'].to_i} tesseract #{tiff_file_base_path}_{}.tif #{text_file_base_path}_{} #{options} 2>&1 ::: #{@pages_to_ocr.join(' ')}")
    # @pages_to_ocr.each { |page| clean_text("#{text_file_base_path}_#{page}.txt") }
  end

  def handle_large_page_size(base_path)
    pdf_images = Rails.root.join("tmp/TESSERACT/#{SecureRandom.uuid}")
    FileUtils.mkdir_p pdf_images unless File.exists?(pdf_images)

    run("pdfimages #{@pdf} #{pdf_images}/IMG")
    run("ls #{pdf_images} | sed 's/IMG-//' | parallel -j#{ENV['TOTAL_CONCURRENT_JOBS_FOR_OCR']} gm convert '#{pdf_images}/IMG-{}' '#{base_path}_$(({.}+1)).tif' 2>&1")
  ensure
    FileUtils.remove_entry_secure(pdf_images) if File.exists?(pdf_images)
  end
end
