class PtabCase < ApplicationRecord
  self.table_name = 'ptab_cases'

  has_many :ptab_case_details
end
