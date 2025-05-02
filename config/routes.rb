# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  resources :booking_requests,
            only: %i[new create],
            path: '/cy/booking-requests',
            locale: :cy,
            module: :welsh_language do
    get :completed, on: :collection
  end

  scope ':locale', locale: /en|cy/ do
    root 'home#show'

    resource :smarter_signposting, only: %i[new destroy], path: 'smarter'
    resource :nudge, only: %i[new]

    constraints format: 'html' do
      resources :categories, only: 'show', path: 'browse'

      get '/book', to: redirect('/appointments', status: 302)

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

      get 'landing', to: 'marketing#landing'
      get 'facebook-landing', to: 'marketing#facebook'
      get 'about', to: 'marketing#about'

      constraints platform: /linkedin|google|facebook/, campaign: /apples|dogs|paint|peppers/ do
        get ':platform-:campaign', to: 'marketing#campaign', as: :marketing_campaign
      end

      scope 'explore-your-options', controller: 'pension_summaries', as: :explore_your_options do
        root action: 'start'

        get 'about-you'
        get 'step-one'
        get 'step-two'
        get 'summary'
        get 'your-experience'
        get 'thank-you'
        get 'download'
        get 'print'

        post 'about-you', action: 'save_about_you'
        post 'step-one', action: 'save_primary_options'
        post 'step-two', action: 'save_secondary_options'
        post 'your-experience', action: 'save_feedback'
        post 'welsh-summary', action: 'save_welsh_summary'
      end

      scope 'employers/:employer_id', module: :employer, as: :employer, locale: :en do
        resources :locations, only: %i[index show] do
          resources :bookings, only: %i[new create] do
            collection do
              get :ineligible
              get :confirmation
              get :times
            end
          end
        end
      end

      resources :bsl_booking_requests,
                only: %i[new create],
                path: 'bsl-booking-requests',
                locale: :en,
                module: :bsl do
        get :completed, on: :collection
      end

      resources :locations, only: %i[index show] do
        collection do
          post 'search'
        end

        member do
          get '/booking-request/step-one',  to: 'booking_requests#step_one'
          post '/booking-request/step-two', to: 'booking_requests#step_two'
          post '/booking-request/complete', to: 'booking_requests#complete'
          get '/booking-request/completed', to: 'booking_requests#completed'
          get '/booking-request/ineligible', to: 'booking_requests#ineligible'
        end
      end

      resources :telephone_appointments, only: %i[new create], path: 'telephone-appointments' do
        collection do
          resource :cancel, only: %i[new create] do
            get :success
            get :failure
          end
        end

        collection do
          get :nudge
          get :ineligible
          get :confirmation
          get :times
        end
      end

      resources :nudge_appointments, only: %i[new create], path: 'nudge-appointments' do
        collection do
          get :ineligible
          get :confirmation
          get :times
        end
      end

      resource :feedback, only: %i[create new] do
        get :thanks
      end

      resource :appointment_summaries, only: %i[new create show], path: 'summary-document' do
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

      %w[base govspeak components govuk_elements layout].each do |action|
        get action, action: action
      end
    end
  end

  delete '/locations_cache', to: 'locations_cache#destroy'

  if Rails.application.config.mount_javascript_test_routes
    mount JasmineRails::Engine => '/specs'
    mount JasmineFixtures => '/spec/javascripts/fixtures'
  end

  get '/summary-50', to: redirect('/summary-50.pdf')
  get '/summary-55', to: redirect('/summary-55.pdf')

  get 'landing-pp', to: redirect('/about')
  get '/', to: redirect('/en')
  get '/*path', to: redirect('/en/%{path}'), constraints: ->(req) { req.params[:path] !~ /^(en|cy)/ }
end
# rubocop:enable Metrics/BlockLength
