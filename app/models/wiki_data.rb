class WikiData

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

  def clean(node)
    node.children.each do |child|
      clean(child)
      child.remove if child.all.content.gsub(/\s+/, '').empty?
    end
  end

def remove_blank_li(input)
  input.css('li').find_all.each do |li|
    li.remove if li.content.blank?
    li.remove if li.content.strip.empty?
  end
end

  def parse_wiki_page(html_input)
    parsed_data = Nokogiri::HTML.parse(html_input).search('#content')
    parsed_data.search('.mw-editsection', '.reflist.references-column-width',
    '#References', '#Further_reading', '#External_links', '.external.text',
     '.navbox', '.reflist', '#Notes', '.refbegin', '#Footnotes').remove
    remove_blank_li(parsed_data)
    parsed_data.css('a').each do |link|
      unless link["href"].nil? || link["href"].include?("#")
        link["href"] = "/wikipedia#{URI.encode(link["href"])}"
      end
    end
    parsed_data
  end

  def http_party_setup(link_input)
    parse_wiki_page(HTTParty.get(link_input).html_safe)
  end

  def name_url_path_end_point_match(url_path)
    url_path.split('/')[-1]
  end


  def save_previous_url(request)
    if request.referer == nil
      "Are you trying to cheat??"
    elsif URI(request.referer).path == '/games'
      "Start of Game"
    else
      "https://en.wikipedia.org#{(URI(request.referer).path).split('/wikipedia')[-1]}"
    end
  end

  def get_links(url)
    cheat_link_array = []
    parsed_data = Nokogiri::HTML.parse(HTTParty.get(url).html_safe).search('#content')
    parsed_data.search('.mw-editsection', '.reflist.references-column-width',
    '#References', '#Further_reading', '#External_links', '.external.text',
     '.navbox', '.reflist', '#Notes', '.refbegin',
     '.refbegin.columns.references-column-width',
     ".reflist.columns.references-column-count.references-column-count-2").remove

    #  Don't need these two classes for the wiki data type removal anymore
    #  '.reflist.columns.references-column-count.references-column-count-2',, '.reflist.references-column-width'

    parsed_data.css("a").map do |link|
      unless link["href"].nil? || link["href"].include?("#")
        cheat_link_array << link["href"]
      end
    end
    cheat_link_array
  end

  def cheating_test(previous_link,params_path)
    if previous_link == "Start of Game"
      true
    elsif previous_link == "Are you trying to cheat??"
      false
    elsif get_links(previous_link).include?("/#{params_path}") == true
      true
    else
      false
    end
  end
end
