module MovesHelper

  def game_move_count
    Move.where(:player_id => current_player.id).count
  end

end
