class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :available_room
  belongs_to :duration
end
