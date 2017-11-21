module DocumentsHelper
  def lit_doc_ocr_priorities
    ENV['LIT_DOC_OCR_PRIORITIES'].split(',')
  end

  def ptab_doc_ocr_priorities
    ENV['PTAB_DOC_OCR_PRIORITIES'].split(',')
  end
end
