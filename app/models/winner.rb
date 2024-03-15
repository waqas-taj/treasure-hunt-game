class Winner < ApplicationRecord
  belongs_to :user

  default_scope { where('distance <= ?', DISTANCE_THRESHOLD) }
end
