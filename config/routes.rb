Rails.application.routes.draw do
  root 'home#show'

  constraints format: 'html' do
    GuideRepository.new.all.each do |guide|
      get guide.slug,
          controller: 'guides',
          action: 'show',
          id: guide.slug
    end

    get 'styleguide/pages/homepage', to: 'styleguide#pages_homepage'
    get 'styleguide/pages/guide', to: 'styleguide#pages_guide'
    get 'styleguide/pages/journey-index', to: 'styleguide#pages_journey_index'
    get 'styleguide/pages/journey-page', to: 'styleguide#pages_journey_page'

    get 'styleguide(/:action)', controller: 'styleguide'
  end
end
