class Owner < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user

  belongs_to :admin

  has_many :pg_buildings

  after_initialize :set_default_status, :if => :new_record?
  def set_default_status
    self.status||="deactive"
  end

  validates :name,presence: true
  validates :phone,presence: true
end
