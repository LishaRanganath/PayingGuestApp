require 'rails_helper'

RSpec.describe Admin, type: :model do
    it "Must have a user" do
        test_data = FactoryBot.create(:admin)
        expect(test_data.user).to be_a(User)
    end
end