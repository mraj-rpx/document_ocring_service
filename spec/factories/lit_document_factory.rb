module Factories
  class FileType < ApplicationRecord
    self.table_name = 'file_types'
  end

  class LitDocumentType < ApplicationRecord
    self.table_name = 'lit_document_types'
  end
end

FactoryGirl.define do
  factory :file_type, class: Factories::FileType do
    sequence(:id)
  end

  factory :lit_document_type, class: Factories::LitDocumentType do
    sequence(:id)
  end

  factory :lit_document do
    url 'http://doc-url'
    rpx_file_name 'lits/1/a.pdf'
    rpx_file_location 'docs'

    before(:create) do |lit_doc|
      file_type = FactoryGirl.create(:file_type)
      lit_document_type = FactoryGirl.create(:lit_document_type)

      lit_doc.lit_document_type_id = lit_document_type.id
      lit_doc.file_type_id = file_type.id
    end
  end
end
