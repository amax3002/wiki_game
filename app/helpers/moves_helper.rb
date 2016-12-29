module MovesHelper

  def game_move_count
    Move.where(:player_id => current_player.id).count
  end

  def gametimer(game_being_timed)
    first_move = Move.where(:player_id => Player.where(:user_id => current_user.id, :game_id => game_being_timed.id)).first
    last_move = Move.where(:player_id => Player.where(:user_id => current_user.id, :game_id => game_being_timed.id)).last
    distance_of_time_in_words first_move.created_at, last_move.updated_at
  end

  def gametimer_leaderboard(game_being_timed, user_input)
    first_move = Move.where(:player_id => Player.where(:user_id => user_input.id, :game_id => game_being_timed.id)).first
    last_move = Move.where(:player_id => Player.where(:user_id => user_input.id, :game_id => game_being_timed.id)).last
    distance_of_time_in_words first_move.created_at, last_move.updated_at
  end

end
