module ChallengesHelper
  def send_challenge_link(game)
    if current_user
      link_to 'Challenge a Friend',  new_game_challenge_path(game), class: "btn btn-warning"
    else
      link_to 'Login to send Challenge',  new_game_challenge_path(game), class: " disabled btn btn-warning"
    end
  end
end
