class WikipediaController < ApplicationController
  def show
    link_path = "https://en.wikipedia.org/#{params["path"]}"

    @page_to_render = HTTParty.get(link_path).html_safe

    @page_to_render = Nokogiri::HTML.parse(@page_to_render).search('#content')
    @page_to_render.css('a').each do |link|
      unless link["href"].nil? || link["href"].include?("#")
        link["href"] = "/wikipedia#{link["href"]}"
      end
    end

    Move.create(player_id: current_player.id, to_point: link_path)

    if params["path"].split('/')[-1] == (current_game.create_end_wiki_path).split('/')[-1]
      @won = true
      return @won
    end

    @page_to_render
  end
end
