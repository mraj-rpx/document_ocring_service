class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.text :ocr_text
      t.string :file

      t.timestamps
    end
  end
end
