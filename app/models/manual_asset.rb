class ManualAsset < ApplicationRecord
  self.table_name = 'acquiflow.manual_assets'

  alias_attribute :country_code, :country
end
