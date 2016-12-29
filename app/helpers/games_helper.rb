module GamesHelper

  def name_url_cleanup(url_path)
    url_path.split('/')[-1].tr('_', ' ').to_s.gsub(" %26","\'s")
  end

  def current_game_start_name
    name_url_cleanup(current_game.create_start_wiki_path)
  end

  def current_game_end_name
    name_url_cleanup(current_game.create_end_wiki_path)
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :page => nil}, {:class => css_class}
  end

end
