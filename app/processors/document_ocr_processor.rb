class DocumentOcrProcessor
  LIMIT = 5
  FREQUENCY = '1m'

  def process!
    documents = Document.todo_from_ui.order(:updated_at).limit(LIMIT)

    documents.each do |document|
      begin
        document.inprogress!
        ocr_content = DocsplitProcessor.new(doc.file.path).process
        document.update_attributes(ocr_text: ocr_content[:ocr_text], status: :completed, exception: nil)
      rescue => exception
        document.update_attributes(exception: exception, status: :failed)
      end
    end
  end
end
