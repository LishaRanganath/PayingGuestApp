require 'rails_helper'

RSpec.describe Owner, type: :model do
    it "must have User and admin" do
        test_data = FactoryBot.create(:user,:owner)
        expect(test_data.user).to be_a(User)
    end
end 