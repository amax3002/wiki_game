Rails.application.routes.draw do


  resource :session, only: [:new, :create, :destroy]
  resources :users, except: [:index]
  resources :moves
  get "/:player_id/moves", controller: :moves, action: :player_moves, as: :player_moves
  resources :games do
    resources :leaderboards, :only => [:index, :show]
    resources :challenges
  end
  get "/wikipedia/*path", to: "wikipedia#show", :constraints => { :path => /.+/ }
  root "welcome#index"
end
