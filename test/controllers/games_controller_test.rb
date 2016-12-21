require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_game_path
    assert_response :success
  end

  test "should decalre winner" do
    get games_path
    b = games(:one).winner?
    assert_equal true, b
  end

end
