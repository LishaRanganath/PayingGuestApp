# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
# db/seeds.rb
# db/seeds.rb
require 'faker'

# Create 3 Admins
3.times do |i|
  user = User.new(email: "admin#{i+1}@gmail.com", password: "admin123", role: "admin")
  if user.save
    admin = user.build_admin(name: Faker::Name.name)
    if admin.save
      # Create 5 Owners for each Admin
      5.times do
        owner_user = User.new(email: Faker::Internet.email, password: 'password', role: 'owner')
        if owner_user.save
          owner = owner_user.build_owner(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, admin: admin)
          if owner.save
            # Create 10 PG Buildings for each Owner
            10.times do
              PgBuilding.create!(
                name: "#{Faker::Address.street_name} PG",
                address: Faker::Address.full_address,
                phone: Faker::PhoneNumber.phone_number,
                email: Faker::Internet.email,
                # image: Faker::Placeholdit.image(size: "600x400", text: 'Building'),
                owner: owner
              )
            end
          end
        end
      end
    end
  end
end

puts "Seeding complete!"

