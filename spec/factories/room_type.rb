FactoryBot.define do
    factory :room_type do
        name {'Single Sharing'}
        association :pg_building
        price {1000}
      end
  end