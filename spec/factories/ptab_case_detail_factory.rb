module Factories
  class PtabCaseDetailPartyType < ApplicationRecord
    self.table_name = 'ptab.ptab_case_detail_party_types'
  end

  class PtabCase < ApplicationRecord
    self.table_name = 'ptab.ptab_cases'
  end
end

FactoryGirl.define do
  factory :ptab_case_detail_party_type, class: Factories::PtabCaseDetailPartyType do
    sequence(:id)
    name 'Test type'
    created_by 'test_user'
    updated_by 'test_user'
  end

  factory :ptab_case, class: Factories::PtabCase do
    sequence(:id)
    case_num '12345'
    filing_date Date.today
    country_code 'US'
    status 'initial'
    tech_center 'test'
    created_by 'test_user'
    updated_by 'test_user'
  end

  factory :ptab_case_detail do
    sequence(:id)
    needs_ocr false
    document_path 'rpx-ptab/1/1.pdf'
    doc_name '1.pdf'
    exhibit_num 1
    filing_date Date.today
    availability 'yes'
    created_by 'test_user'
    updated_by 'test_user'

    before(:create) do |ptab|
      party_type = FactoryGirl.create(:ptab_case_detail_party_type)
      ptab_case = FactoryGirl.create(:ptab_case)
      ptab.ptab_case_detail_party_type_id = party_type.id
      ptab.ptab_case_id = ptab_case.id
    end
  end
end
