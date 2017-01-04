class WikipediaController < ApplicationController
  def show
    @wiki_parser = WikiData.new

    @link_path = "https://en.wikipedia.org/#{params['path']}"
    @from_path = @wiki_parser.save_previous_url(request)

    @page_to_render = @wiki_parser.http_party_setup(@link_path)

    @not_cheating = @wiki_parser.cheating_test(@from_path,params['path'])

    Move.create(player_id: current_player.id, to_point: @link_path, from_point: @from_path, cheater: @not_cheating)

    if @wiki_parser.name_url_path_end_point_match(params["path"]) == @wiki_parser.name_url_path_end_point_match(current_game.create_end_wiki_path)
      @won = true
      @won
    end
  end
end
