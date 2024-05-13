require 'rails_helper'

RSpec.describe PgBuilding, type: :model do
    it "Validates the presence of owner" do
        test_data = FactoryBot.create(:pg_building)
        expect(test_data.owner).to be_a(Owner)
    end

    # describe 'Associations' do
    #     it { should have_many(:room_types) }
    #     it { should have_many(:categories) }
    #     it { should have_many(:available_rooms) }
    #   end

    # describe "Asociations" do
    #     it { should have_many(:categories).dependent(:destroy) }
    # end

    it "Validates if Address is not nil " do
        test_data = FactoryBot.create(:pg_building)
        expect(test_data.address).not_to be_nil
    end

    it "Validates phone is not nil and is of length 10" do
        test_data = FactoryBot.create(:pg_building)
        expect(test_data.phone).not_to be_nil
        expect(test_data.phone.length).to eq(10)
    end

    it "validates email is present and is of the required format" do
        test_data = FactoryBot.create(:pg_building)
        expect(test_data.email).not_to be_nil
        expect(test_data).to be_valid
    end

    it "Validates if name is present" do
        test_data = FactoryBot.create(:pg_building)
        expect(test_data.name).not_to be_nil
    end

end