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

  test "should decalre loser" do
    get games_path
    b = games(:Game1).winner?(users(:Laurent))
    assert_equal "You did not Finish....weak", b
  end

  test "should get starting url path" do
    get games_path
    b = games(:Game1).create_start_wiki_path
    assert_equal "/wiki/Ottoman_Empire", b
  end

  test "should get ending url path" do
    get games_path
    b = games(:Game1).create_end_wiki_path
    assert_equal "/wiki/John_Bukovsky", b
  end

  test "should be able to destroy" do
    game_id = games(:Game1).id
    delete game_path(game_id)
    refute Game.find_by(id: game_id)
  end

  test "should be able to update a Game" do
    game_id = games(:Game1).id
    patch game_path(game_id), params: { game: { start_point: "/wiki/Dis_Guy" } }
    assert_response :redirect
    assert_equal "/wiki/Dis_Guy", Game.find(game_id).start_point
  end

  # test "can create Game" do
  #   game_start = games(:Game1).start_point
  #   game_end = games(:Game1).end_point
  #   post games_path, params: { game: { start_point: game_start, end_point: game_end } }
  #
  #   assert_response :redirect
  #   assert_equal Game.last.start_point, "wiki/Ottoman_Empire"
  #   assert_equal Game.last.end_point, "wiki/John_Bukovsky"
  # end

  test "show specific game information" do
    get game_path(Game.last, Player.last)

    assert_select "h1", "Client Details for Alex Guy"
  end
end
