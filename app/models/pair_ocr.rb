class PairOcr < ApplicationRecord
  self.table_name = 'pair.pair_ocr'
  OCR_LIMIT = 50

  scope :ocrable_documents, -> { self.where(needs_ocr: true).order(:ocr_priority).limit(OCR_LIMIT) }
end
