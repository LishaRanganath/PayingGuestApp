class RoomBooking < ApplicationRecord
  belongs_to :customer
  belongs_to :room_type
  belongs_to :category
  belongs_to :duration
end
