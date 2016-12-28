class LeaderboardsController < ApplicationController
  def index
  end

  def show
      @game = Game.find(params[:id])
      redirect_to "/games/#{@game.id}/leaderboard"
  end
end
