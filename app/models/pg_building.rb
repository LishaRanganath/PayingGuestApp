class PgBuilding < ApplicationRecord
    belongs_to :owner
    has_one_attached :image

    has_many :room_types, dependent: :destroy
    has_many :categories, dependent: :destroy
    has_many :available_rooms, dependent: :destroy
    
    validates :name,presence: true
    validates :address,presence: true
    validates :email,presence: true,format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, uniqueness: true
    validates :phone,presence: true
end
