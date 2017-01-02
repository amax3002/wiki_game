require 'test_helper'

class MovesControllerTest < ActionDispatch::IntegrationTest
include MovesHelper

  def current_player
    Player.find_by(id: session[:player_id])
  end

  test "should get move count" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)
      b = game_move_count
      assert_equal 0, b
  end


end
