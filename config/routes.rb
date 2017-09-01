# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  scope ':locale', locale: /en|cy/ do
    root 'home#show'

    constraints format: 'html' do
      resources :categories, only: 'show', path: 'browse'

      get '/book', to: redirect('/appointments', status: 302)

      get '/contact', to: 'contact#new'
      post '/contact', to: 'contact#create'

      get '/*id',
          controller: 'guides',
          action: 'show',
          as: :guide,
          constraints: ->(req) { GuideRepository.slugs.include?(req.params[:id]) }

      get 'guaranteed-income/estimate', to: 'calculators/guaranteed_income#show'
      get 'adjustable-income/estimate', to: 'calculators/adjustable_income#show'
      get 'leave-pot-untouched/estimate', to: 'calculators/leave_pot_untouched#show'
      get 'take-cash-in-chunks/estimate', to: 'calculators/take_cash_in_chunks#show'
      get 'take-whole-pot/estimate', to: 'calculators/take_whole_pot#show'

      post 'questions', to: 'questions#next'

      get 'landing', to: 'marketing#index'
      get 'facebook-landing', to: 'marketing#facebook'
      get 'about', to: 'marketing#about'

      scope 'explore-your-options', controller: 'pension_summaries', as: :explore_your_options do
        root action: 'start'

        get 'step-one'
        get 'step-two'
        get 'summary'
        get 'download'
        get 'print'
      end

      namespace :tesco, locale: :en do
        resources :locations, only: :index do
          member do
            get '/bookings/step-one', to: 'bookings#step_one'
          end
        end
      end

      resources :locations, only: [:index, :show] do
        member do
          get '/booking-request/step-one',  to: 'booking_requests#step_one'
          post '/booking-request/step-two', to: 'booking_requests#step_two'
          post '/booking-request/complete', to: 'booking_requests#complete'
          get '/booking-request/completed', to: 'booking_requests#completed'
          get '/booking-request/ineligible', to: 'booking_requests#ineligible'
        end
      end

      resources :telephone_appointments, only: %i(new create), path: 'telephone-appointments' do
        collection do
          get :ineligible
          get :confirmation
          get :times
        end
      end

      resource :feedback, only: [:create, :new] do
        get :thanks
      end

      resource :appointment_summaries, only: %i(new create show), path: 'summary-document' do
        post :download, on: :member
        post :print, on: :member
      end
    end
  end

  constraints format: 'html' do
    scope path: 'styleguide', controller: 'styleguide', locale: :en do
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

  delete '/locations_cache', to: 'locations_cache#destroy'

  if Rails.application.config.mount_javascript_test_routes
    mount JasmineRails::Engine => '/specs'
    mount JasmineFixtures => '/spec/javascripts/fixtures'
  end

  get 'landing-pp', to: redirect('/about')
  get '/', to: redirect('/en')
  get '/*path', to: redirect('/en/%{path}'), constraints: ->(req) { req.params[:path] !~ /^(en|cy)/ }
end
