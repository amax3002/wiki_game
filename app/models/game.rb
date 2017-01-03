class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :challenges, dependent: :destroy
  has_many :moves, through: :players
  before_destroy :destroy_players_moves

  def winner?(player)
    if Move.where(player: player, :to_point => "https://en.wikipedia.org#{self.end_point}").present? == true
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

  private

  def destroy_players_moves
    self.players.delete_all
  end
end
