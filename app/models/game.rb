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
  # 
  # def word_count
  #   doc = (Nokogiri::HTML.parse(HTTParty.get(self.start_point))).text
  #   words = doc.gsub("\n","").gsub("\t","").gsub("\n","").gsub("\n","").gsub("  ", " ").split(' ')
  #
  #   words.size
  # end
  #
  # def article_size_generate
  #   until true
  #     article = HTTParty.get("https://en.wikipedia.org/wiki/Special:Random").request.uri
  #     article.word_count > 5000
  #   end
  #   article
  # end

end
