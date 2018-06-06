class LitDocument < ApplicationRecord
  self.table_name = 'lit_documents'

  EXISTING_DOCUMENT_STATUS = 3
  DOCUMENT_STATUS = [1, 34, 4, 5, 7, 21, 11, 10, 33, 13, 75, 16, 17, 18]
  FROM_DATE = '2018-02-01' # This's going to changed, it's added temperorily

  has_many :docket_entry_documents_maps
  scope :ocrable_docs, -> { where(needs_ocr: true, document_status_id: EXISTING_DOCUMENT_STATUS).order(:ocr_priority) }

  scope :ocrable_documents, -> {
    joins(docket_entry_documents_maps: [docket_entry: [:lit]])
      .where('document_status_id = ? AND lit_document_type_id IN (?) AND ocr_text_s3_path IS NULL AND (ocr_text IS NULL OR ocr_text = ?)',
             EXISTING_DOCUMENT_STATUS, DOCUMENT_STATUS, '-- NOT OCR-ED --')
      .order('core.lits.filed_date DESC, core.lits.id')
  }
  scope :ocrable_docs_ongoing, -> { self.ocrable_documents }
  scope :ocrable_docs_backfilling, -> { self.ocrable_documents.where('core.lits.filed_date < ?', FROM_DATE) }
end
