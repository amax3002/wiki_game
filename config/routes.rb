Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resources :users, except: [:index]
  resources :games do
    resources :leaderboard, :only => [:index, :show]
  end
  resources :moves
  get "/wikipedia/*path", to: "wikipedia#show"
  root "welcome#index"
end
