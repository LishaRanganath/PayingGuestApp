require 'rails_helper'

RSpec.describe "AvailableRooms", type: :request do
  describe "POST /create" do
    it "creates the rooms" do
      owner = FactoryBot.create(:owner)
      owner_user = owner.user
      sign_in owner_user
      pg_building = FactoryBot.create(:pg_building, owner: owner)
      category = FactoryBot.create(:category, pg_building: pg_building)
      room_type = FactoryBot.create(:room_type, pg_building: pg_building)
      post available_rooms_path, params: {
        available_room: {
          pg_building_id: pg_building.id,
          room_type_id: room_type.id,
          category_id: category.id,
          availability: 12
          }
        }
        expect(response).to have_http_status(302)
    end
  end

  describe "DELETE/destroy" do
    it "Deletes The Room for a specific building" do
      owner = FactoryBot.create(:owner)
      owner_user = owner.user
      sign_in owner_user
      pg_building = FactoryBot.create(:pg_building, owner: owner)
      category = FactoryBot.create(:category, pg_building: pg_building)
      room_type = FactoryBot.create(:room_type, pg_building: pg_building)
      room = FactoryBot.create(:available_room, pg_building: pg_building, room_type: room_type, category: category)
      delete  available_room_path(id: room.id)
      expect(response).to have_http_status(302)
    end
  end
end
