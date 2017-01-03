class ChallengeMailer < ApplicationMailer

  def send_challenge(challenge)
    @challenge = challenge
    mail(
      to: challenge,
      subject: 'You have been challenged to a Wikipedia game'
    )
  end

end
