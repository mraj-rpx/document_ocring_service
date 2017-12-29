class LitDocument < ApplicationRecord
  self.table_name = 'lit_documents'

  EXISTING_DOCUMENT_STATUS = 3
  scope :ocrable_docs, -> { where(needs_ocr: true, document_status_id: EXISTING_DOCUMENT_STATUS).order(:ocr_priority) }
end
