class ChallengeMailer < ApplicationMailer::Base

  def send_challenge(challenge,current_user)
    @game = challenge
    mail(
      to: challenge,
      subject: 'You have been challenged to a Wikipedia game'
    )
  end

end
