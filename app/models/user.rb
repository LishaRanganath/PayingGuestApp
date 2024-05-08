class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings, dependent: :destroy

  has_one :owner, dependent: :destroy
  has_one :admin, dependent: :destroy

  enum role:[:user,:owner,:admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role||=:user
  end

  def with_customer
    build_customer if customer.nil?
    self
  end
end
