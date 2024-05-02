class Category < ApplicationRecord
    has_many :available_rooms, dependent: :destroy
    has_many :room_bookings
    belongs_to :pg_building
end
