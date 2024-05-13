require 'rails_helper'

RSpec.describe "RoomTypesSpec.rbs", type: :request do
  describe "POST /create" do
    it "creates the Room Type for a specific Pg Building" do
      owner = FactoryBot.create(:owner)
      owner_user = owner.user
      # debugger
      sign_in owner_user
      pg_building = FactoryBot.create(:pg_building, owner: owner)
      post room_types_path, params: {
        room_type: {
          name: "Single-Sharing",
          price: 1000,
          pg_building_id: pg_building.id
          }
        }
      
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE/destroy" do
    it "Deletes The Room Type for a specific building" do
      owner = FactoryBot.create(:owner)
      owner_user = owner.user
      # debugger
      sign_in owner_user
      pg_building = FactoryBot.create(:pg_building, owner: owner)
      room_type = FactoryBot.create(:room_type, pg_building: pg_building)
      delete  room_type_path(id: room_type.id)
      expect(response).to have_http_status(302)
    end
  end

  describe "PUT/update" do
    it "Updates the Room Type of a specific building" do
      owner = FactoryBot.create(:owner)
      owner_user = owner.user
      # debugger
      sign_in owner_user
      pg_building = FactoryBot.create(:pg_building, owner: owner)
      room_type = FactoryBot.create(:room_type, pg_building: pg_building)
      put room_type_path(id: room_type.id), params: { room_type: { name: "Double Sharing" } }
      expect(response).to have_http_status(302)
      expect(room_type.reload.name).to eq("Double Sharing")
    end
  end

end
