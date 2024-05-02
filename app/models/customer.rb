class Customer < ApplicationRecord
  belongs_to :user
  has_many :room_bookings
  validates :name,presence: true
  validates :phone,presence: true

end
