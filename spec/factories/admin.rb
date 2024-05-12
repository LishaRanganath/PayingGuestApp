FactoryBot.define do
    factory :admin do
        name {'John Doe'}
        association :user
      end
end