module GamesHelper

  def name_url_cleanup(url_path)
    URI.decode(url_path.split('/')[-1].tr('_', ' ').to_s.gsub(" %26","\'s"))
  end

  def current_game_start_name
    name_url_cleanup(current_game.create_start_wiki_path)
  end

  def current_game_end_name
    name_url_cleanup(current_game.create_end_wiki_path)
  end

end
