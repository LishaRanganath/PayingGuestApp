class AvailableRoom < ApplicationRecord
  belongs_to :room_type
  belongs_to :category
end
