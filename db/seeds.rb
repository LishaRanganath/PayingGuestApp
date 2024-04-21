# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
u1=User.build(email:"admin1@gmail.com", password:"admin123",role:"admin")
u1.save
admin = u1.build_admin(name: "Lisha")
admin.save

u2=User.build(email:"admin2@gmail.com", password:"admin123",role:"admin")
u2.save
admin = u2.build_admin(name: "Parshwa")
admin.save