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

  def parse_wiki_page(html_input)
    parsed_data = Nokogiri::HTML.parse(html_input).search('#content')
    parsed_data.search('.mw-editsection', '.reflist.references-column-width', '#References', '#External_links', '.external.text', '.navbox').remove
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

end
