class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,omniauth_providers: [:google_oauth2]


      def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name # assuming the user model has a name
        user.avatar_url = auth.info.image # assuming the user model has an image
      end
    end
      
  validates_uniqueness_of :email, case_sensitive: false, if: :email_changed?
  has_many :bookings, dependent: :destroy

  has_one :owner, dependent: :destroy
  has_one :admin, dependent: :destroy

  enum role:[:user,:owner,:admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role||=:user
  end


end
