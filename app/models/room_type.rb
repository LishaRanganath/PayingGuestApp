class RoomType < ApplicationRecord
    has_many :available_rooms, dependent: :destroy
    has_many :room_bookings , dependent: :destroy
    belongs_to :pg_building
end
