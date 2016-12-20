class Move < ApplicationRecord
  has_many :users
  has_many :users, through: :players
  has_many :wikipedias
end
