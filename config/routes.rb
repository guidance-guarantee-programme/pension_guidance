Rails.application.routes.draw do
  root 'home#show'

  constraints format: 'html' do
    GuideRepository.new.all.each do |guide|
      get guide.slug,
          controller: 'guides',
          action: 'show',
          id: guide.slug
    end

    get 'styleguide/pages/guide', controller: 'styleguide#pages_guide'
    get 'styleguide/pages/homepage', controller: 'styleguide#pages_homepage'

    get 'styleguide(/:action)', controller: 'styleguide'
  end
end
