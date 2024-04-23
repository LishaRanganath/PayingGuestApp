class PgBuilding < ApplicationRecord
    belongs_to :owner
    has_one_attached :image

    validates :name,presence: true
    validates :address,presence: true
    validates :name,presence: true
    validates :name,presence: true
end
