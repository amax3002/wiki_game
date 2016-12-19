Rails.application.routes.draw do
  resources :pagerenders

  get "/wikipedia/*path", to: "wikipedia#show"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
