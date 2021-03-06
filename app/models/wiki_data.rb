require 'uri'
require "addressable/uri"
class WikiData
  TAGS_TO_REMOVE = ['.mw-editsection', '.reflist.references-column-width',
  '#References', '#Further_reading', '#External_links', '.external.text',
   '.navbox', '.reflist', '#Notes', '.refbegin', '#Footnotes',
   '.references', '.reference', '.refbegin.columns.references-column-width',
   ".reflist.columns.references-column-count.references-column-count-2",
   ".noprint.Inline-Template", ".metadata", '#Bibliography', '.citation.book',
   '.mw-indicators', '.citation.web']

  def article_size_generate
    counter = 0
    flag = false
    until flag
      redirect = HTTParty.get("https://en.wikipedia.org/wiki/Special:Random", follow_redirects: false)
      location_path = redirect.headers["location"]
      article = URI(location_path).path

      flag = word_count(article) > 5_000
      counter += 1
      puts "#{counter}: #{word_count(article)}"
      break if counter > 10
    end
    article
  end

  def word_count(response)
    doc = (Nokogiri::HTML.parse(HTTParty.get("https://en.wikipedia.org#{response}"))).search("#bodyContent").text

    words = doc.gsub("\n","").gsub("\t","")
    words.size
  end

  def remove_blank_li_and_dl(input)
    input.css('li').find_all.each do |li|
      li.remove if li.content.blank?
      li.remove if li.content.strip.empty?
    end
    input.css('h2').find_all.each do |h2|
      h2.remove if h2.content.blank?
      h2.remove if h2.content.strip.empty?
    end
    input.css('h3').find_all.each do |h3|
      h3.remove if h3.content.blank?
      h3.remove if h3.content.strip.empty?
    end
    input.css('h4').find_all.each do |h4|
      h4.remove if h4.content.blank?
      h4.remove if h4.content.strip.empty?
    end
    # input.css('dl').find_all.each do |dl|
    #   dl.remove
    # end
    input.css('a').find_all.each do |a|
      a.remove if a["href"] == '/wiki/Wikipedia:Link_rot'
      a.remove if a["href"] == '/wiki/Help:Attached_KML'
      a.remove if a["role"] == 'navigation'
    end
    input.css('div').find_all.each do |div|
      div.remove if div["role"] == 'navigation'
    end
  end

  def parse_wiki_page(html_input)

    parsed_data = Nokogiri::HTML.parse(html_input).search('#content')
    parsed_data.search(*TAGS_TO_REMOVE).remove
    remove_blank_li_and_dl(parsed_data)
    parsed_data.css('a').each do |link|
      unless link["href"].nil? || link["href"].include?("#")
        link["href"] = p "/wikipedia#{link["href"]}"
      end
    end
    parsed_data
  end

  def get_page(url)
    Rails.logger.warn("Getting Wikiepedia Page: #{url}")
    parse_wiki_page(HTTParty.get(url).html_safe)
  end

  def expand_wikipedia_article(article)
    encoded_article = Addressable::URI.encode_component(
      article,
      Addressable::URI::CharacterClasses::PATH
    )
    "https://en.wikipedia.org/#{encoded_article}"
  end

  def params_path_formatter(url_path)
    url_path.split('/')[-1]
  end


  def save_previous_url(request)
    if request.referer == nil
      "Are you trying to cheat??"
    elsif URI(request.referer).path == '/games' || (URI(request.referer).path).include?("/challenges") || (URI(request.referer).path).include?("/new")
      "Start of Game"
    else
      "https://en.wikipedia.org#{(URI(request.referer).path).split('/wikipedia')[-1]}"
    end
  end

  def links_to_check_cheating(url)
    cheat_link_array = []
    parsed_data = Nokogiri::HTML.parse(HTTParty.get(url)).search('#content')
    parsed_data.search(*TAGS_TO_REMOVE).remove
    parsed_data.css("a").map do |link|
      unless link["href"].nil? || link["href"].include?("#")
        cheat_link_array << URI.decode(link["href"])
      end
    end
    cheat_link_array
  end

  def cheating_test(previous_link,params_path)
    if previous_link == "Start of Game"
      true
    elsif previous_link == "Are you trying to cheat??"
      false
    elsif links_to_check_cheating(previous_link).include?("/#{params_path}") == true
      true
    else
      false
    end
  end
end
