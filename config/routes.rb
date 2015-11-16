Rails.application.routes.draw do
  root 'home#show'

  constraints format: 'html' do
    GuideRepository.new.all.each do |guide|
      get guide.slug,
          controller: 'guides',
          action: 'show',
          id: guide.slug
    end

    resources :search_results, only: 'index', path: 'search'
    resources :locations, only: [:index, :show]

    scope path: 'styleguide', controller: 'styleguide' do
      scope path: 'pages' do
        get 'homepage', action: 'pages_homepage'
        get 'guide', action: 'pages_guide'
        get 'journey-index', action: 'pages_journey_index'
        get 'journey-page', action: 'pages_journey_page'
        get 'appointments', action: 'pages_appointments'
        get 'book', action: 'pages_book'
        get 'locations-search', action: 'pages_locations_search'
        get 'locations-index', action: 'pages_locations_index'
        get 'locations-invalid', action: 'pages_locations_invalid'
        get 'locations-show', action: 'pages_locations_show'
        get 'locations-show-call-centre', action: 'pages_locations_show_call_centre'
        get 'search-results', action: 'pages_search_results'
        get 'search-header', action: 'pages_search_header'
      end

      get '(/:action)'
    end
  end

  get 'take-whole-pot/results', controller: 'take_whole_pot_calculator', action: 'show'

  if Rails.application.config.mount_javascript_test_routes
    mount JasmineRails::Engine => '/specs'
    mount JasmineFixtures => '/spec/javascripts/fixtures'
  end
end
