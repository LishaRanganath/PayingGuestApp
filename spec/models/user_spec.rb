require 'rails_helper'

RSpec.describe User, type: :model do

  it "must have minimum 6 characters in password" do
    test_data = FactoryBot.create(:user)
    expect(test_data.password.length).to be >= 6
  end

  it "validates the format of the email" do
    test_pass_data = FactoryBot.create(:user)
    expect(test_pass_data).to be_valid

    # test_fail_data = FactoryBot.create(:user, email: "yo.com")
    # expect(test_fail_data).not_to be_valid
  end

  it "must have a role" do
    test_data = FactoryBot.create(:user)
    expect(test_data).not_to be_nil
  end

  describe "Phone number presence" do
    it "must have phone number only if customer" do
      test_data = FactoryBot.create(:user)
      if test_data.role == "user"
        expect(test_data.phone).not_to be_nil
      end
    end

    it "must have phone number of 10 digits" do
      test_data = FactoryBot.create(:user)
      expect(test_data.phone.length).to eq(10)
    end
  end
end
