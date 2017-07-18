class AddColumnStatusToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :status, :integer, default: 1
    add_column :documents, :exception, :string
  end
end
