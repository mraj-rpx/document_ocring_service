class LitDocument < ApplicationRecord
  self.table_name = 'core.lit_documents'

  EXISTING_DOCUMENT_STATUS = 3
  scope :ocrable_docs, -> { where(needs_ocr: true, document_status_id: EXISTING_DOCUMENT_STATUS).order(:updated_at) }
end
