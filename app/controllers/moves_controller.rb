class MovesController < ApplicationController
  def player_moves
    @player = Player.find_by id: params[:player_id]
    @unique_endpoints_hash = Hash[Move.new.make_hash_node(@player)]
    @usable_edges = Move.new.make_hash_edge(@player, Hash[Move.new.make_hash_node(@player)])
  end

  # private
  #   def move_params
  #     params.permit(:move).permit(:player_id)
  #   end

end
