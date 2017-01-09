class ChallengesController < ApplicationController
  def new
    @game = Game.find_by id: params[:game_id]
    @challenge = Challenge.new(game_id: @game)
  end

  def create
    @challenge = Challenge.create(challenge_params)
    flash[:success] = "You successfully sent a Challenge!"

    if @challenge.save
      @challenge.recipient_status_known(@challenge.recipient_email)
      ChallengeMailer.send_challenge(@challenge).deliver_now
      redirect_to games_path
    else
      render :new, notice: 'Email Exists'
    end
  end

  def personal_challenges
    @recipient = Challenge.find_by recipient_id: params[:recipient_id]
  end


  private

  def challenge_params
    params.require(:challenge).permit(:game_id, :challenger_id, :recipient_id, :recipient_email, :recipient_name)
  end
end
