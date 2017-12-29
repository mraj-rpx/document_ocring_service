class PtabCaseDetail < ApplicationRecord
  self.table_name = 'ptab_case_details'

  scope :ocrable_docs, -> { where(needs_ocr: true).order(:ocr_priority) }
end
