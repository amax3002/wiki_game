Rails.application.routes.draw do

  get 'moves/new'

  get 'moves/show'

  resource :session, only: [:new, :create, :destroy]
  resources :users, except: [:index]
  resources :games
  resources :games
  get "/wikipedia/*path", to: "wikipedia#show"
  root "welcome#index"
end
