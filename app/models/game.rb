class Game < ApplicationRecord
  has_and_belongs_to_many :players

  def replace_appostrophie_s
    self.gsub!("%27s","\'s'")
  end
end
