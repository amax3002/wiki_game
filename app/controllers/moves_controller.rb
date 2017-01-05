class MovesController < ApplicationController
  def player_moves
    @player = Player.find_by id: params[:player_id]
  end
end
