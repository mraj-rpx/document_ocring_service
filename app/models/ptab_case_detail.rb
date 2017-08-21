class PtabCaseDetail < ApplicationRecord
  self.table_name = 'ptab.ptab_case_details'

  scope :ocrable_docs, -> { where(needs_ocr: true).order(:updated_at) }
end