require 'test_helper'

class TupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tups_index_url
    assert_response :success
  end

  test "should get create" do
    get tups_create_url
    assert_response :success
  end

  test "should get show" do
    get tups_show_url
    assert_response :success
  end

end
