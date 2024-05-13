FactoryBot.define do
  factory :user do
    email { 'johnny@gmail.com' }
    password { '111111' }
    phone { '4356278656' }

    trait :admin do
      email { 'admin1@gmail.com' }
      role { 'admin' }
    end

    trait :owner do
      email { 'owner@example.com' }
      role { 'owner' }
    end
  end
end