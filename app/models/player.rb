class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :challenge, through: :game
  has_many :moves
end
