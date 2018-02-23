class DocketEntry < ActiveRecord::Base
  self.table_name = 'core.docket_entries'

  has_many :docket_entry_documents_maps
  belongs_to :lit
end
