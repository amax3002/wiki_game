class ChallengeMailer < ApplicationMailer

  def send_challenge(challenge)
    @challenge = challenge
    @url = new_user_url
    mail(

      to: challenge.recipient_email,
      subject: 'You have been challenged to a Wikipedia game'
    ) do |format|
        format.html { render send_challenge: 'send_challenge.html.erb' }
        format.text
    end
  end

end
