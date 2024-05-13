require 'rails_helper'

RSpec.describe Owner, type: :model do
    describe "Validates Association" do
        it "Must have User" do
            test_data = FactoryBot.create(:owner)
            expect(test_data.user).to be_a(User)
        end

        it "Must have admin" do
            test_data = FactoryBot.create(:owner)
            expect(test_data.admin).to be_a(Admin)
        end
    end
     
    it "validates the format of the email" do
        test_data = FactoryBot.create(:owner)
        expect(test_data).to be_valid
    end

    it "validates the number of digits in phone number" do
        test_data = FactoryBot.create(:owner)
        expect(test_data.phone.length).to eq(10)
    end

end 