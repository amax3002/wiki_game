require 'test_helper'

class LeaderboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get game_leaderboards_path(game_id: Game.last)
    assert_response :success
  end
end
