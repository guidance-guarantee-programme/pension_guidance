Rails.application.routes.draw do
  root 'home#show'

  constraints format: 'html' do
    GuideRepository.new.all.each do |guide|
      get guide.slug,
          controller: 'guides',
          action: 'show',
          id: guide.slug
    end

    resources :locations, only: [:index, :show]

    scope path: 'styleguide', controller: 'styleguide' do
      scope path: 'pages' do
        get 'homepage', action: 'pages_homepage'
        get 'guide', action: 'pages_guide'
        get 'journey-index', action: 'pages_journey_index'
        get 'journey-page', action: 'pages_journey_page'
        get 'locator-entry', action: 'pages_locator_entry'
        get 'locator-results', action: 'pages_locator_results'
      end

      get '(/:action)'
    end
  end

  if Rails.application.config.mount_javascript_test_routes
    mount JasmineRails::Engine => '/specs'
    mount JasmineFixtures => '/spec/javascripts/fixtures'
  end
end
