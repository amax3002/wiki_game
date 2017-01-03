class ChallengesController < ApplicationController
  def new
    @game = Game.find_by id: params[:game_id]
    @challenge = Challenge.new(game_id: @game)
  end

  def create
    @challenge = Challenge.create(challenge_params)
    session["message"] = "You have sent a challenge"
    ChallengeMailer.send_challenge(@challenge).deliver_now
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
