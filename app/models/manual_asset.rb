class ManualAsset < ApplicationRecord
  self.table_name = 'manual_assets'

  alias_attribute :country_code, :country
end
