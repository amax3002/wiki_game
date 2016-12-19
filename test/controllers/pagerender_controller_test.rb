require 'test_helper'

class PagerenderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pagerender_index_url
    assert_response :success
  end

end
