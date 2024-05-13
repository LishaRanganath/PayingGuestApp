FactoryBot.define do
    factory :admin do
        name {'John Doe'}
        association :user, factory: [:user, :admin]
      end
end