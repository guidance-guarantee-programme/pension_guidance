Rails.application.routes.draw do
  root 'home#show'

  constraints format: 'html' do
    resources :articles, only: [:show]

    get 'styleguide/pages/article', controller: 'styleguide#pages_article'
    get 'styleguide/pages/homepage', controller: 'styleguide#pages_homepage'

    get 'styleguide(/:action)', controller: 'styleguide'
  end
end
