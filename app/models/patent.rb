class Patent < ApplicationRecord
  enum asset_source: {'C' => 0, 'D' => 1, 'M' => 2 }
end
