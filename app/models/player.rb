class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_one :challenge, through: :game
  has_many :moves
end
