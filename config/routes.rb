Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resources :users, except: [:index]
  resources :moves
  resources :games do
    resources :leaderboards, :only => [:index, :show]
    resources :challenges, :only => [:new, :create, :show]
  end
  get "/wikipedia/*path", to: "wikipedia#show"
  root "welcome#index"
end
