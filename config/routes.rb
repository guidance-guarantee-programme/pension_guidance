Rails.application.routes.draw do
  resources :articles, only: [:show]

  get 'styleguide/pages/article', to: 'styleguide#pages_article'
  get 'styleguide/pages/homepage', to: 'styleguide#pages_homepage'

  get 'styleguide(/:action)', to: 'styleguide'

  root 'home#show'
end
