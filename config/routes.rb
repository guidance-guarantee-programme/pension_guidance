Rails.application.routes.draw do
  resources :articles, only: [:show]

  get 'styleguide(/:action)', to: 'styleguide'

  root 'home#show'
end
