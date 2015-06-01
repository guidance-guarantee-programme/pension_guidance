Rails.application.routes.draw do
  root 'home#show'

  constraints format: 'html' do
    GuideRepository.new.all.each do |guide|
      get guide.slug,
          controller: 'guides',
          action: 'show',
          id: guide.slug
    end

    scope path: 'styleguide', controller: 'styleguide' do
      scope path: 'pages' do
        get 'homepage', action: 'pages_homepage'
        get 'guide', action: 'pages_guide'
        get 'journey-index', action: 'pages_journey_index'
        get 'journey-page', action: 'pages_journey_page'
      end

      get '(/:action)'
    end
  end

  unless Rails.env.production?
    mount JasmineRails::Engine => '/specs'
    mount JasmineFixtures => '/spec/javascripts/fixtures'
  end
end
