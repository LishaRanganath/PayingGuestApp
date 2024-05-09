class AvailableRoom < ApplicationRecord
  belongs_to :room_type
  belongs_to :category
  belongs_to :pg_building
  has_many :bookings
end
