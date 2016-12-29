require 'test_helper'

class MovesHelperTest < ActionView::TestCase
  test "should get move count" do
    new_session(:Alex)
    new_game(:Game1)
      game_move_count
      assert_equal 1, b
  end
end
