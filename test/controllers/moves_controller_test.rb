require 'test_helper'

class MovesControllerTest < ActionDispatch::IntegrationTest
include MovesHelper

  def current_player
    Player.find_by(id: session[:player_id])
  end

  test "player moves path" do
    new_session(:Alex)
    follow_redirect!

    get player_moves_path(players(:Player1))

    assert_response :success
  end

  test "should get move count" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)
      b = game_move_count
      assert_equal 0, b
  end

  test "clean_url" do
    moves = Move.new(
     player_id: 62,
     to_point: "https://en.wikipedia.org/wiki/Aircraft_industry_of_Russia",
     from_point: "https://en.wikipedia.org/wiki/Economy_of_Russia",
     cheater: true
    )
    clean_url = Move.new.clean_move_url(moves.to_point)
    assert_equal clean_url, "Aircraft industry of Russia"
  end

  test "move_clean_url" do
    moves = Move.new(
     player_id: 62,
     to_point: "https://en.wikipedia.org/wiki/Aircraft_industry_of_Russia",
     from_point: "https://en.wikipedia.org/wiki/Economy_of_Russia",
     cheater: true
    )
    clean_url = move_name_url_cleanup(moves.to_point)
    assert_equal clean_url, "Aircraft industry of Russia"
  end

  test "unique endpoint creation for map" do
    b = Move.new.unique_end_points_game_moves(players(:Player1))
    assert_equal ["Symphony X", "Ottoman Empire"], b
  end

  test "create key list" do
    b = Move.new.make_key_list(players(:Player1))
    assert_equal [1, 2], b
  end

  test "create hash node from key list" do
    b = Move.new.make_hash_node(players(:Player1))
    assert_equal [["Symphony X", 1], ["Ottoman Empire", 2]], b
  end

  test "create hash edges from player and hash nodes" do
    b = Move.new.make_hash_edge(players(:Player1), Hash[Move.new.make_hash_node(players(:Player1))])
    assert_equal [{:from=>1, :to=>2}, {:from=>2, :to=>1}], b
    assert_equal 1, b[0][:from]
  end

  test "funny game messages 0 moves" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)
    assert_equal "Play!", game_move_count_funny_message
  end

  test "funny game messages 2 to 5 moves" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(5, current_player.id)

    assert_equal "Keep Going!", game_move_count_funny_message
  end

  test "funny game messages 6 to 9 moves" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(9, current_player.id)

    assert_equal "You are still in this, don't stop!", game_move_count_funny_message
  end

  test "funny game messages 10 to 11 moves" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(11, current_player.id)

    assert_equal "Double digits, don't feel bad, it happens", game_move_count_funny_message
  end

  test "funny game messages 12, 13" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(13, current_player.id)

    assert_equal "I mean never to me....", game_move_count_funny_message
  end

  test "funny game messages 14, 15" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(15, current_player.id)

    assert_equal "...or anyone that I know.", game_move_count_funny_message
  end

  test "funny game messages 16, 19" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(19, current_player.id)

    assert_equal "Whatever, as long as you haven't the 20's who am I to judge.", game_move_count_funny_message
  end

  test "funny game messages 20, 20" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(20, current_player.id)

    assert_equal "20 moves. I am \"impressed\".", game_move_count_funny_message
  end

  test "funny game messages 21, 22" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(22, current_player.id)

    assert_equal "You know you can cheat by opening a new tab, going to wikipedia, and trying there.", game_move_count_funny_message
  end

  test "funny game messages 23, 24" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(24, current_player.id)

    assert_equal "There is no need to public embarrass yourself like this.", game_move_count_funny_message
  end

  test "funny game messages 25, 30" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(30, current_player.id)

    assert_equal "You should feel bad. I feel bad for you.", game_move_count_funny_message
  end

  test "funny game messages 31, 32" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(32, current_player.id)

    assert_equal "O.M.G. please give up", game_move_count_funny_message
  end

  test "funny game messages 33, 34" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(34, current_player.id)

    assert_equal "STOOOOOOOP", game_move_count_funny_message
  end

  test "funny game messages 35, 36" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(36, current_player.id)

    assert_equal "Are you even listening to me?", game_move_count_funny_message
  end

  test "funny game messages 37, 99" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(95, current_player.id)

    assert_equal "I hate you.", game_move_count_funny_message
  end

  test "funny game messages 100, 200" do
    new_session(:Alex)
    follow_redirect!
    new_game(:Game1)

    create_moves_for_message(120, current_player.id)

    assert_equal "What are you doing with your life???", game_move_count_funny_message
  end


end
