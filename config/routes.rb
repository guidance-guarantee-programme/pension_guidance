Rails.application.routes.draw do
  root 'home#show'

  constraints format: 'html' do
    resources :guides, only: [:show]

    get 'styleguide/pages/guide', controller: 'styleguide#pages_guide'
    get 'styleguide/pages/homepage', controller: 'styleguide#pages_homepage'

    get 'styleguide(/:action)', controller: 'styleguide'
  end
end
