class RoomType < ApplicationRecord
    has_many :available_rooms, dependent: :destroy
    belongs_to :pg_building
end
