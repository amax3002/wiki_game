require 'test_helper'

class ChallengesControllerTest < ActionDispatch::IntegrationTest
#
# def setup
#     Challenge.destroy_all
# end

  test "should get new" do
    new_session(:Alex)
    follow_redirect!
    get new_game_challenge_path(Game.last.id)

    assert_response :success
  end

  test "should get create" do
    new_session(:Alex)
    follow_redirect!
    game = Game.last
    post game_challenges_path(game), params: { challenge: {
      game_id: game.id,
      challenger_id: users(:Alex).id,
      recipient_id: users(:Laurent).id,
      recipient_email: 'lguy@comcast.net',
      recipient_name: users(:Laurent).full_name
      } }

    assert_response :redirect
  end

  test "personal challenges" do
    Challenge.destroy_all
    new_session(:Alex)
    follow_redirect!
    game = Game.last
    post game_challenges_path(game), params: { challenge: {
      game_id: game.id,
      challenger_id: users(:Alex).id,
      recipient_id: users(:Laurent).id,
      recipient_email: 'lguy@comcast.net',
      recipient_name: users(:Laurent).full_name
      } }
      follow_redirect!

    delete session_path
      follow_redirect!

    new_session(:Laurent)
      follow_redirect!

    get personal_challenges_path(users(:Laurent))

    assert_select "h2", "Challenges Recieved"
  end

end
