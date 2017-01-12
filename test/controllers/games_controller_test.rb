require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  include GamesHelper

  def setup
    stub_request(
      :get,
      "https://en.wikipedia.org/wiki/Symphony_X"
    ).to_return(
      status: 200,
      body: File.read("test/fixtures/wikiepedia_responses/symphony_x.html"),
      headers: { "Content-Type" => "text/html" }
    )
    stub_request(
      :get,
      "https://en.wikipedia.org/wiki/Ottoman_Empire"
    ).to_return(
      status: 200,
      body: File.read("test/fixtures/wikiepedia_responses/ottoman_empire.html"),
      headers: { "Content-Type" => "text/html" }
    )

    stub_request(
      :get,
      "https://en.wikipedia.org/wiki/Special:Random"
    ).to_return(
      {
        status: 302,
        body: "",
        headers: { "Location" => "https://en.wikipedia.org/wiki/Ottoman_Empire" }
      },
      status: 302,
      body: "",
      headers: { "Location" => "https://en.wikipedia.org/wiki/Symphony_X" }
    )
  end

  def current_game
    Game.find_by(id: session[:game_id])
  end
  def current_user
    User.find_by(id: session[:current_user_id])
  end

  test "should get new" do
    new_session(:Alex)
    follow_redirect!

    get new_game_path
    assert_response :success
  end

  test "should decalre winner" do
    new_session(:Alex)
    follow_redirect!

    get games_path
    game_played = games(:Game1)
    game_played.update(start_point: "/wiki/Ottoman_Empire")
    game_played.update(end_point: "/wiki/Symphony_X")
    b = game_played.winner?(players(:Player1))
    assert_equal "WON!", b
  end

  test "should decalre cheater" do
    new_session(:Thomas)
    follow_redirect!

    get games_path
    b = games(:Game1).winner?(players(:Player3))
    assert_equal "Filthy Cheater", b
  end

  test "should decalre loser" do
    new_session(:Alex)
    follow_redirect!

    get games_path
    b = games(:Game1).winner?(players(:Player2))
    assert_equal "You did not Finish....weak", b
  end

  test "should get starting url path" do
    new_session(:Alex)
    follow_redirect!

    get games_path
    b = games(:Game1).create_start_wiki_path
    assert_equal "wiki/Ottoman_Empire", b
  end

  test "should get ending url path" do
    new_session(:Alex)
    follow_redirect!

    get games_path
    b = games(:Game1).create_end_wiki_path
    assert_equal "wiki/Symphony_X", b
  end

  # test "should be able to update a Game" do
  #   game_id = games(:Game1).id
  #   patch game_path(game_id), params: { game: { start_point: "/wiki/Dis_Guy" } }
  #   assert_response :redirect
  #   assert_equal "/wiki/Dis_Guy", Game.find(game_id).start_point
  # end

  test "can create Game" do
    new_session(:Alex)
    follow_redirect!
    game_start = games(:Game1).start_point
    game_end = games(:Game1).end_point
    post games_path, params: { game: { start_point: game_start, end_point: game_end } }
    assert_response :redirect
    assert_equal Game.last.start_point, "/wiki/Ottoman_Empire"
    assert_equal Game.last.end_point, "/wiki/Symphony_X"
  end

  test "Play specific game (show)" do
    new_session(:Alex)
    follow_redirect!

    game = games(:Game1)
    game.update(start_point: "/wiki/Ottoman_Empire")
    get game_path(game)
    follow_redirect!

    assert_select "h2", "YOU CHEATED!!!! YOU CHEATED!!!! YOU CHEATED!!!! YOU CHEATED!!!!"
  end

  test "delete specific game (destroy)" do
    new_session(:Alex)
    follow_redirect!
    game = games(:Game1)
    delete game_path(game)
    follow_redirect!

    assert_select "h1", "Choose Game"
  end

  test "user should be an admin" do
    a = users(:Alex)
    a.roles << Role.find_by(name: "admin")
    new_session(:Alex)
    follow_redirect!

    assert_equal true, current_user.admin?
  end

  test "test current game start/end name helper method" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)
    start_name_input = current_game_start_name
    end_name_input = current_game_end_name
    assert_equal "Ottoman Empire", start_name_input
    assert_equal "Symphony X", end_name_input
  end

  test "test game self search method" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)
    start_name_input = current_game_start_name
    end_name_input = current_game_end_name
    assert_equal "Ottoman Empire", start_name_input
    assert_equal "Symphony X", end_name_input
  end

end
