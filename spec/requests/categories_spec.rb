require 'rails_helper'

RSpec.describe "CategoriesSpec.rbs", type: :request do
  describe "POST /create" do
    it "creates the Category for a speacific Pg Building" do
      owner = FactoryBot.create(:owner)
      owner_user = owner.user
      # debugger
      sign_in owner_user
      pg_building = FactoryBot.create(:pg_building, owner: owner)
      post categories_path, params: {
        category: {
          name: "AC",
          price: 300,
          pg_building_id: pg_building.id
          }
        }
      
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE/destroy" do
    it "Deletes The Category for a specific building" do
      owner = FactoryBot.create(:owner)
      owner_user = owner.user
      # debugger
      sign_in owner_user
      pg_building = FactoryBot.create(:pg_building, owner: owner)
      category = FactoryBot.create(:category, pg_building: pg_building)
      delete  category_path(id: category.id)
      expect(response).to have_http_status(302)
    end
  end

  describe "PUT/update" do
    it "Updates the category of a specific building" do
      owner = FactoryBot.create(:owner)
      owner_user = owner.user
      # debugger
      sign_in owner_user
      pg_building = FactoryBot.create(:pg_building, owner: owner)
      category = FactoryBot.create(:category, pg_building: pg_building)
      put category_path(id: category.id), params: { category: { name: "Non-Ac" } }
      expect(response).to have_http_status(302)
      expect(category.reload.name).to eq("Non-Ac")
    end
  end

end
