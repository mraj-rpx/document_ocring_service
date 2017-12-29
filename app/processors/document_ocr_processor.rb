class DocumentOcrProcessor < OcrProcessorBase
  FREQUENCY = '1m'

  def process!
    documents = Document.todo_from_ui.order(:updated_at).limit(LIMIT)

    documents.each do |document|
      begin
        document.inprogress!
        ocr_content = DocsplitProcessor.new(document.file.path).process
        document.update_attributes(ocr_text: ocr_content[:ocr_text], exception: nil)

        # NOTE: Additional step here to extract patent details from the OCRed text
        PatentDetailExtractor.new([document]).extract!
      rescue => exception
        Honeybadger.notify(exception, context: {document_id: document.id, document_type: Document})
        document.update_attributes(exception: exception, status: :failed)
      end
    end
  end
end
