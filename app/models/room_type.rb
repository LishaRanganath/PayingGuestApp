class RoomType < ApplicationRecord
    has_many :available_rooms
    has_many :room_bookings
    belongs_to :pg_building
end
