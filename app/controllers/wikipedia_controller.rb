class WikipediaController < ApplicationController
  def show

    @page_to_render = HTTParty.get("https://en.wikipedia.org/#{params["path"]}").html_safe

    @page_to_render = Nokogiri::HTML.parse(@page_to_render)
    @page_to_render.css('a').each do |link|
      unless link["href"].nil?
        link["href"] = "/wikipedia#{link["href"]}"
      end
    end


    if params["path"].split('/')[-1] == "Africa"
      @won = true
      return @won
    end

    @page_to_render
  end
end
