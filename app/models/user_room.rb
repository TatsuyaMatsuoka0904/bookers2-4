class UserRoom < ApplicationRecord
  belongs_to :users
  belongs_to :room
end
