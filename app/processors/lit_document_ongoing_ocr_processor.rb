class LitDocumentOngoingOcrProcessor < OcrProcessorBase
  FREQUENCY = '2m'

  def process!
    documents = LitDocument.ocrable_docs_ongoing.limit(LIMIT)
    documents.each{ |document| lit_doc_ocr(document) }
  end
end
