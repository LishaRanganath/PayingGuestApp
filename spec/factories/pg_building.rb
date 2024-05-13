FactoryBot.define do
    factory :pg_building do
        name {'Airbnb1'}
        email {'airbnb1@gmail.com'}
        phone {'9673546245'}
        address {'Marathalli,Bangalore'}
        association :owner
      end
  end