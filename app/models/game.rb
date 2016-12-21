class Game < ApplicationRecord
  has_many :players
  has_many :moves, through: :players

  def replace_appostrophie_s
    self.gsub!("%27s","\'s'")
  end
end
