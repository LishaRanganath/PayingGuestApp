require 'rails_helper'

RSpec.describe OwnersController, type: :request do

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

  describe "POST /create" do
    it "creates the owner and redirects" do
      admin = FactoryBot.create(:admin)
      admin_user = admin.user
      # debugger
      sign_in admin_user
      
      post owners_path, params: {
        owner: {
          name: "john doe",
          phone: "21324356476",
          admin_id: admin.id,
          user_attributes: {
            email: "alec@gmail.com",
            password: "password"
          }
        }
      }
      
      expect(response).to have_http_status(302)
    end
  end

  describe "PUT /activate" do
    it "Activates the Owner" do
      admin = FactoryBot.create(:admin)
      admin_user = admin.user
      # debugger
      sign_in admin_user
      # debugger
      owner = FactoryBot.create(:owner, admin: admin)
      put activate_owner_path(id: owner.id)
      expect(owner.reload.status).to eq("active")
      # expect(response).to redirect_to(owners_path)
      expect(response).to have_http_status(302)  
    end
  end


  # describe "PUT /activate" do
  #   it "Deactivates the Owner" do
  #     Rails.application.load_seed
  #     user = User.find_by(email: "admin1@gmail.com")
  #     sign_in user
  #     owner= Owner.find_by(status: "active")
  #     put deactivate_owner_path(id: owner)
  #     expect(owner.reload.status).to eq("deactive")
  #     # expect(response).to redirect_to(owners_path)
  #     expect(response).to have_http_status(302)  
  #   end
  # end


  describe "DELETE/destroy" do
    it "Deletes the owner" do
      admin = FactoryBot.create(:admin)
      admin_user = admin.user
      sign_in admin_user
      owner = FactoryBot.create(:owner, admin: admin)
      delete owner_path(id: owner.id)
      expect(response).to have_http_status(302)
    end
  end

  describe "PUT/update" do
    it "Updates the owner using owners#update" do
    admin = FactoryBot.create(:admin)
      admin_user = admin.user
      sign_in admin_user
      owner = FactoryBot.create(:owner, admin: admin)
      put owner_path(owner.id), params: { owner: { name: "Lisha" } }
      expect(response).to have_http_status(302)
      expect(owner.reload.name).to eq("Lisha")
    end
  end

end