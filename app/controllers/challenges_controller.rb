class ChallengesController < ApplicationController
  def new
    @game = Game.find_by id: params[:game_id]
    @challenge = Challenge.new(game_id: @game)
  end

  def create
    binding.pry
    @challenge = Challenge.create(challenge_params)
    session["message"] = "You have sent a challenge"
    if @challenge.save
      # send mailer action here
      redirect_to games_path
    else
      render :new
    end
  end


  private

  def challenge_params
    params.require(:challenge).permit(:game_id, :challenger_id, :recipient_id)
  end
end
