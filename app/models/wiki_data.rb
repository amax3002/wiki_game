class WikiData

  def article_size_generate
    counter = 0
    flag = false
    until flag
      article = URI(HTTParty.get("https://en.wikipedia.org/wiki/Special:Random").request.uri).path
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
end
