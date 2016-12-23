class WikipediaController < ApplicationController
  def show
    wiki_parser = WikiData.new()
    link_path = "https://en.wikipedia.org/#{params["path"]}"

    @page_to_render = wiki_parser.http_party_setup(link_path)

    Move.create(player_id: current_player.id, to_point: link_path)

    if wiki_parser.name_url_path_end_point_match(params["path"]) == wiki_parser.name_url_path_end_point_match(current_game.create_end_wiki_path)
      @won = true
      return @won
    end

    @page_to_render
  end
end
