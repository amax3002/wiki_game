class Challenge < ApplicationRecord
  has_one :user, through: :player
  has_many :players, through: :game
  belongs_to :game

  def recipient_status_known(email)
    if User.exists?(email: email)
      a = User.find_by(email: email)
      self.update_attribute :recipient_id, a.id
    end
  end

end
