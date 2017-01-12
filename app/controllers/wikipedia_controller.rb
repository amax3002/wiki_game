class WikipediaController < ApplicationController
  def show
    @wiki_parser = WikiData.new
    @link_path = @wiki_parser.expand_wikipedia_article(params["path"])

    @from_path = @wiki_parser.save_previous_url(request)

    @page_to_render = @wiki_parser.get_page(@link_path)

    @not_cheating = @wiki_parser.cheating_test(@from_path, params['path'])
    Move.find_or_create_by(player_id: current_player.id, to_point: @link_path, from_point: @from_path, cheater: @not_cheating)

    if @wiki_parser.params_path_formatter(params["path"]) == @wiki_parser.params_path_formatter(current_game.create_end_wiki_path)
      @won = true
      @won
    end
  end
end
