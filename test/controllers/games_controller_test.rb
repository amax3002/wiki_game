require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_game_path
    assert_response :success
  end

  test "should decalre winner" do
    get games_path
    b = games(:Game1).winner?(users(:Alex))
    assert_equal "WON!", b
  end

  test "should get word count for article" do
    get games_path
    b = games(:Game1).word_count
    assert_equal 18666, b
  end

end
