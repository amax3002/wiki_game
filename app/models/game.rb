class Game < ApplicationRecord
  has_many :players
  has_many :moves, through: :players

  def winner?(current_user_input)
    if (Move.where(:player_id => Player.where(:game_id => self.id, :user_id => current_user_input.id), :to_point => "https://en.wikipedia.org#{self.end_point}").present?) == true
      return "WON!"
    else
      return "You did not Finish....weak"
    end
  end

  def create_start_wiki_path
    URI(self.start_point).path
  end

  def create_end_wiki_path
    URI(self.end_point).path
  end

  def self.search(search)
    if search
      where("LOWER(start_point) LIKE LOWER(?) OR LOWER(end_point) LIKE LOWER(?)", "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end


# Move.where(:player_id => Player.where(:game_id => a.id, :user_id => 1), :to_point => a.end_point).present?
