class PatAssignmentAttachment < ApplicationRecord
  self.table_name = 'pat_assignment_attachments'

  scope :ocrable_assignments, -> { where('s3_ocr_url IS NOT NULL AND is_parsed = ? AND parsing_exception LIKE ?',false,"%no implicit conversion from nil to integer%").order(:created_at) }
  scope :parsable_assignments, -> { where('s3_ocr_url IS NOT NULL AND is_parsed = ? AND parsing_exception IS NULL', false).order(:created_at) }
end
