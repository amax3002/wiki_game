class Move < ApplicationRecord
  belongs_to :player

  def self.game_move_count
    where(:player_id => current_player.id).count
  end
end
