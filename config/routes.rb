Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, except: [:index]
  resources :pagerenders
  get "/wikipedia/*path", to: "wikipedia#show"
  root "welcome#index"
end
