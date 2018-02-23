class DocketEntryDocumentsMap < ActiveRecord::Base
  self.table_name = 'core.docket_entry_documents_map'

  belongs_to :lit_documents
  belongs_to :docket_entry
end
