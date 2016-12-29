class LeaderboardsController < ApplicationController
  def index
    @game = Game.find_by id: params[:game_id]
  end
end
