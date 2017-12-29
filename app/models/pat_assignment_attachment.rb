class PatAssignmentAttachment < ApplicationRecord
  self.table_name = 'pat_assignment_attachments'

  scope :ocrable_assignments, -> { where('s3_ocr_url IS NULL').order(:created_at) }
  scope :parsable_assignments, -> { where('s3_ocr_url IS NOT NULL AND is_parsed = ?', false).order(:created_at) }
end
