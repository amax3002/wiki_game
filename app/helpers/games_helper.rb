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

  def play_random_game_link
    if current_user
      link_to "Play Random Game", games_path, method: :post, class: "btn btn-lg btn-primary btn-block", data: {disable_with: "Creating Game..."}
    else
      link_to "Login to play", games_path, method: :post, class: "disabled btn btn-lg btn-primary btn-block", data: {disable_with: "Creating Game..."}
    end
  end

  def play_game_link(game)
    if current_user
      link_to 'Play', game, class: "btn btn-info wiggle-me"
    else
      link_to 'Login to play', game, class: "disabled btn btn-info"
    end
  end

  def column_with_method
    return "col_width_setting_disabled" unless current_user

    if current_user.admin?
      "col_width_setting_admin"
    else
      "col_width_setting"
    end
  end

  def play_custom_game_link
    #Create Custom Game
    if current_user
      link_to "Custom Game Feature Coming Soon", new_game_path, class: "disabled btn btn-lg btn-info btn-block"
    else
      link_to "Login to Create Custom Game", new_game_path, class: "disabled btn btn-lg btn-info btn-block"
    end
  end

end
