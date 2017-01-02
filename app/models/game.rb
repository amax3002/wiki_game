class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :moves, through: :players
  before_destroy :destroy_players_moves

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

  private

  def destroy_players_moves
    self.players.delete_all
  end
end
