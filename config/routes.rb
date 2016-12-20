Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  resources :pagerenders

  get "/wikipedia/*path", to: "wikipedia#show"

end
