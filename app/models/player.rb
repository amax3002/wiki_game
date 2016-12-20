class Player < ApplicationRecord
  has_and_belongs_to_many :games
  has_and_belongs_to_many :moves
end
