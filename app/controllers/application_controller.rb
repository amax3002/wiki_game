class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception

  helper_method :current_user, :current_game

  def current_user
    User.find_by(id: session["current_user_id"])
  end

  def current_game
    Game.find_by(id: session[:game_id])
  end

end
