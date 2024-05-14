FactoryBot.define do
    factory :available_room do
        association :pg_building
        association :room_type
        association :category
        availability {12}
    end
end