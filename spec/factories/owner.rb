FactoryBot.define do
  factory :owner do
      name {'John Doe'}
      status{'deactive'}
      association :user, factory: [:user, :owner]
      association :admin
    end
end