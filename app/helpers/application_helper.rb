module ApplicationHelper

  def randomized_background_image
    images = ["../images/background.jpg", "../images/book_wallpaper_background.jpg", "../images/book_words_background.png"]
    images[rand(images.size)]
  end

end
