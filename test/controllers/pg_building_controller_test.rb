require "test_helper"

class PgBuildingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pg_building_index_url
    assert_response :success
  end
end
