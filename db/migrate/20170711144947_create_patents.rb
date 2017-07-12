class CreatePatents < ActiveRecord::Migration[5.1]
  def change
    create_table :patents do |t|
      t.string :patnum
      t.integer :asset_source
      t.integer :asset_source_id
      t.integer :patent_number
      t.string :country_code
      t.boolean :matched_with_country_code, default: true
      t.integer :document_id

      t.timestamps
    end
    add_foreign_key :patents, :documents
  end
end
