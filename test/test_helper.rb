ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'simplecov'
SimpleCov.start 'rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def new_session(user)
   post session_path, params: { email: users(user).email, password: "password" }
  end

  def new_game(game)
   get game_path(games(game).id), params: { start_point: games(game).start_point, end_point: games(game).end_point }
  end
end
