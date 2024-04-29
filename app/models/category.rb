class Category < ApplicationRecord
    has_many :available_rooms
    belongs_to :pg_building
end
