FactoryBot.define do
    factory :category do
        name {'AC'}
        price {300}
        association :pg_building
      end
  end