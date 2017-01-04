class ChallengeMailer < ApplicationMailer

  def send_challenge(challenge)
    @challenge = challenge
    @url = 'http://example.com/login'
    mail(
      to: challenge.recipient_email,
      subject: 'You have been challenged to a Wikipedia game'
    )
  end

end
