Rails.application.routes.draw do
  root 'home#show'

  constraints format: 'html' do
    resources :categories, only: 'show', path: 'browse'

    get '/book', to: redirect('/appointments', status: 302)

    GuideRepository.new.all.each do |guide|
      get guide.slug,
          controller: 'guides',
          action: 'show',
          id: guide.slug
    end

    get 'guaranteed-income/estimate', to: 'calculators/guaranteed_income#show'
    get 'adjustable-income/estimate', to: 'calculators/adjustable_income#show'
    get 'leave-pot-untouched/estimate', to: 'calculators/leave_pot_untouched#show'
    get 'take-cash-in-chunks/estimate', to: 'calculators/take_cash_in_chunks#show'
    get 'take-whole-pot/estimate', to: 'calculators/take_whole_pot#show'

    resources :locations, only: [:index, :show]

    resource :appointment_summaries, only: %i(new create show), path: 'summary-document' do
      post :download, on: :member
      post :print, on: :member
    end

    scope path: 'styleguide', controller: 'styleguide' do
      scope path: 'pages' do
        get 'homepage', action: 'pages_homepage'
        get 'guide', action: 'pages_guide'
        get 'appointments', action: 'pages_appointments'
        get 'book', action: 'pages_book'
        get 'locations-search', action: 'pages_locations_search'
        get 'locations-index', action: 'pages_locations_index'
        get 'locations-invalid', action: 'pages_locations_invalid'
        get 'locations-show', action: 'pages_locations_show'
        get 'locations-show-call-centre', action: 'pages_locations_show_call_centre'
      end

      get '/', action: :index

      %w(base govspeak components govuk_elements layout).each do |action|
        get action, action: action
      end
    end
  end

  if Rails.application.config.mount_javascript_test_routes
    mount JasmineRails::Engine => '/specs'
    mount JasmineFixtures => '/spec/javascripts/fixtures'
  end
end
