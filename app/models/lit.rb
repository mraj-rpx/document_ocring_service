class Lit < ActiveRecord::Base
  self.table_name = 'core.lits'

  has_many :docket_entries
end
