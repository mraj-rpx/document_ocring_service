class PairOcr < ApplicationRecord
  self.table_name = 'pair.pair_ocr'

  scope :ocrable_documents, -> { self.where(needs_ocr: true).order(:ocr_priority) }
  scope :ocred_documents, -> { self.where("needs_ocr=? AND ocr_s3_path IS NOT NULL",false) }
  scope :total_documents_on_priority, -> { self.all.group(:ocr_priority).count }
  scope :ocred_documents_on_priority, -> { self.where("needs_ocr =?",false).group(:ocr_priority).count }
  scope :ocrable_documents_on_priority, -> { self.where("(needs_ocr = ? OR needs_ocr IS NULL)",true)
    .group(:ocr_priority).count }
end
