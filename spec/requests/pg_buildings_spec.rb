require 'rails_helper'

RSpec.describe "PgBuildings", type: :request do

  describe "POST/create" do 
    it "Creates a Pg Building" do
      owner = FactoryBot.create(:owner)
      owner_user = owner.user
      sign_in owner_user

      post  pg_buildings_path, params: {
        pg_building: {
          name: "Airbnb1",
          phone: "21324356476",
          owner_id: owner,
          address: "Bangalore",
          email: "airbnb1@gmail.com",
        }
      }
      
    expect(response).to have_http_status(302)
    end
  end

  describe "DELETE/destroy" do
    it "Deletes the Pg Building" do
      owner = FactoryBot.create(:owner)
      owner_user = owner.user
      sign_in owner_user
      pg_building = FactoryBot.create(:pg_building, owner: owner)
      delete pg_building_path(id: pg_building.id)
      expect(response).to have_http_status(302)
    end
  end

  describe "Filtering of Pg Buildings" do
    it "Searches Specific Building" do
      owner = FactoryBot.create(:owner)
      FactoryBot.create(:pg_building, owner: owner)
      get search_buildings_path, params: { query: "Airbnb1" }
      expect(response).to have_http_status(200)
      expect(response.body).to include("Airbnb1")
    end

    # it "Filters all builsings based on given conditions" do
    #   owner = FactoryBot.create(:owner)
    #   FactoryBot.create(:pg_building, owner: owner)

    # end
  end

  it "Shows details of a particular building" do
    owner = FactoryBot.create(:owner)
    pg_building = FactoryBot.create(:pg_building, owner: owner)
    get pg_building_path(id: pg_building.id)
    expect(response).to have_http_status(200)
    expect(response).to render_template("pg_buildings/show")
  end

  
end
