require 'rails_helper'

RSpec.describe RoomType, type: :model do
    describe "Validates the data" do
        
        it "Checks the presence of name" do
            test_data = FactoryBot.create(:room_type)
            expect(test_data.name).not_to be_nil
        end

        it "Checks if the price input is integer" do
            test_data = FactoryBot.create(:room_type)
            expect(test_data.price).to be_an_instance_of(Integer)
        end

        it "Checks the presence of price" do
            test_data = FactoryBot.create(:room_type)
            expect(test_data.price).not_to be_nil
        end
    end

    it "Validates the associatoion" do
        test_data = FactoryBot.create(:room_type)
        expect(test_data.pg_building).to be_a(PgBuilding)
    end
end