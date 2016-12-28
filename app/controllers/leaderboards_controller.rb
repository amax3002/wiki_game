class LeaderboardsController < ApplicationController
  def index
    @game = Game.find_by id: params[:game_id]
  end

  def show
    @game = Game.find(params[:id])
  end
end
