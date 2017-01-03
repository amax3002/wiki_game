Rails.application.routes.draw do


  resource :session, only: [:new, :create, :destroy]
  resources :users, except: [:index]
  resources :moves
  resources :games do
    resources :leaderboards, :only => [:index, :show]
  end
  resources :challenges
  get "/wikipedia/*path", to: "wikipedia#show"
  root "welcome#index"
end
