module MovesHelper

  def game_move_count
    Move.where(:player_id => current_player.id).count
  end

  def gametimer(game_being_timed)
    first_move = Move.where(:player_id => current_player.id).first
    last_move = Move.where(:player_id => current_player.id).last

    seconds_diff = (first_move.created_at - last_move.created_at).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  def gametimer_leaderboard(player)
    first_move = player.moves.first
    last_move = player.moves.last

    seconds_diff = (first_move.created_at - last_move.created_at).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

end
