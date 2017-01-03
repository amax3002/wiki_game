class Challenge < ApplicationRecord
  has_many :players, through: :game
  belongs_to :game

end
