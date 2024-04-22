class PgBuilding < ApplicationRecord
    belongs_to :owner

    validates :name,presence: true
    validates :address,presence: true
    validates :name,presence: true
    validates :name,presence: true
end
