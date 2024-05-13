FactoryBot.define do
  factory :owner do
      name {'John Doe'}
      status{'deactive'}
      phone {'9536427356'}
      association :user, factory: [:user, :owner]
      association :admin
    end
end