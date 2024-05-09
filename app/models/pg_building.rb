class PgBuilding < ApplicationRecord
    belongs_to :owner
    has_one_attached :image

    has_many :room_types
    has_many :categories
    has_many :available_rooms
    
    validates :name,presence: true
    validates :address,presence: true
    validates :name,presence: true
    validates :name,presence: true
end
