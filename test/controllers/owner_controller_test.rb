require "test_helper"

class OwnerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get owner_new_url
    assert_response :success
  end
end
