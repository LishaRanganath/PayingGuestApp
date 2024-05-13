class RoomType < ApplicationRecord
    has_many :available_rooms, dependent: :destroy
    belongs_to :pg_building

    validates :price, presence: :true
    validates :name, presence: :true
end
