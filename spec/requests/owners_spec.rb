require 'rails_helper'

RSpec.describe OwnersController, type: :request do

  # describe "POST /create" do
  #   it "render owner#create " do
  #    owner = Owner.new
  #    owner = Owner.create(name: "John Doe",phone: "3425367548", status: "deactive")
  #     # expect(response).to redirect_to()
  #   end

  # end
  describe "GET /index" do
    it "renders the owner/index template" do
      Rails.application.load_seed
      user = User.find_by(email: "admin1@gmail.com")
      sign_in user
      get owners_path, params: { role: "admin" }
      expect(response).to have_http_status(200)
      expect(response).to render_template("owners/index")
      # expect(response.body).to include("All Owners")
    end
  end

  describe "POST/create" do
    it "Creates the Owner by redirecting to owner#create" do
      Rails.application.load_seed
      user = User.find_by(email: "admin1@gmail.com")
      sign_in user
      puts user.email
      user = post owners_path, params: { owner: { name: "john doe", phone: "21324356476", admin_id: 1, user_attributes: { id: 1,email: "alec@gmail.com", password: "password" } } }
      expect(response).to have_http_status(302)  
      # puts user.name
    end
  end

  # describe "GET /activate" do
  #   it "Activates the Owner" do
  #     Rails.application.load_seed
  #     user = User.find_by(email: "admin1@gmail.com")
  #     sign_in user
  #     post owners_path, params: { owner: {id: 1, name: "john doe", phone: "21324356476", admin_id: 1, user_attributes: { email: "john@example.com", password: "password", role: "admin" } } }
  #     owner = Owner.last
  #     put activate_owner_path(id: owner.id)
  #     # expect(owner.reload.status).to eq("active")
  #     # expect(response).to redirect_to(owners_path)
  #     expect(response).to have_http_status(302)  

  #   end
  # end

  # describe "DELETE/destroy" do
  #   it "Destroys the Owner" do
  #     Rails.application.load_seed
  #     user = User.find_by(email: "admin1@gmail.com")
  #     sign_in user
  #     puts user.email
  #     user = User.find_by(email: "xoxo@gmail.com")
  #     puts user.email
  #     # delete owner_path(user.owner.id)
  #     # expect(response).to have_http_status(200)
  #   end
  # end

end