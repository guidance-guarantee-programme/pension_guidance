Rails.application.routes.draw do
  resources :articles, only: [:show]

  get 'styleguide/pages/article', controller: 'styleguide#pages_article'
  get 'styleguide/pages/homepage', controller: 'styleguide#pages_homepage'

  get 'styleguide(/:action)', controller: 'styleguide'

  root 'home#show'
end
