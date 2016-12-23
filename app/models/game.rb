class Game < ApplicationRecord
  has_many :players
  has_many :moves, through: :players

  def replace_appostrophie_s
    self.gsub!("%27s","\'s'")
  end

  def winner?(current_user_input)
    if (Move.where(:player_id => Player.where(:game_id => self.id, :user_id => current_user_input.id), :to_point => self.end_point).present?) == true
      return "WON!"
    else
      return "Did not Finish....weak"
    end
  end

  def create_start_wiki_path
    URI(self.start_point).path
  end

  def create_end_wiki_path
    URI(self.end_point).path
  end

end
