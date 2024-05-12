FactoryBot.define do
    factory :user do
        email { 'johndoe@gmail.com' }
        password { '111111' }
        role {'admin'}
        phone {'4356278656'}
      end
end