class ArticleCheck
  def frequencies(content)
    Hash[
      content.group_by(&:downcase).map{ |word, instances|
        [word,instances.length]
        }.sort_by(&:last).reverse
      ]
  end

  def word_count(web_site)

  doc = Nokogiri::HTML(HTTParty.get("https://en.wikipedia.org/wiki/Ottoman_Empire"))
  doc.css('b').remove
  text = doc.css('pre').map(&:text)
  # => ["\r\n\r\n\r\n\r\n\r\n\r\n                          Written by\r\n\r\n                       David Congalton\r\n\r\n\r\n\r\n\r\n                                                       July 14 2012\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n    North Hayworth Avenue, off Sunset Boulevard. A quiet, tree-\r\n    lined residential street. Note the small apartment complex\r\n    set back from the curb.\r\n\r\n\r\n    Our narrator is HENRY OBERT (O-BURT)(30).\r\n\r\n               This is where whe...

  text.join(' ')
  # => "\r\n\r\n\r\n\r\n\r\n\r\n                          Written by\r\n\r\n                       David Congalton\r\n\r\n\r\n\r\n\r\n                                                       July 14 2012\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n    North Hayworth Avenue, off Sunset Boulevard. A quiet, tree-\r\n    lined residential street. Note the small apartment complex\r\n    set back from the curb.\r\n\r\n\r\n    Our narrator is HENRY OBERT (O-BURT)(30).\r\n\r\n               This is where wher...

  words = text.join(' ').scan(/\w+/)
  # => ["Written", "by", "David", "Congalton", "July", "14", "2012", "North", "Hayworth", "Avenue", "off", "Sunset", "Boulevard", "A", "quiet", "tree", "lined", "residential", "street", "Note", "the", "small", "apartment", "complex", "set", "back", "from", "the", "curb", "Our", "narrator", "is", "HENRY", "OBERT", "O", "BURT", "30", "This", "is", "where", "where", "F", "Scott", "Fitzgerald", "died", "on", "December", "21", "1940", "INSERT", "ARCHIVAL", "PHOTOS", "of", "Fitzgerald", "His", "w...

  return frequencies(words)
  # => {"the"=>827, "to"=>486, "i"=>398, "a"=>397, "s"=>284, "and"=>279, "in"=>273, "of"=>238, "hannah"=>234, "you"=>232, "henry"=>223, "it"=>214, "on"=>207, "her"=>200, "is"=>192, "his"=>178, "he"=>165, "for"=>162, "t"=>152, "that"=>151, "colette"=>148, "she"=>142, "at"=>137, "john"=>133, "alan"=>118, "this"=>112, "my"=>109, "up"=>105, "all"=>88, "william"=>88, "as"=>85, "what"=>84, "with"=>84, "but"=>83, "be"=>76, "camera"=>76, "not"=>74, "one"=>74, "can"=>73, "out"=>70, "m"=>69, "from"=>...
  end
end
