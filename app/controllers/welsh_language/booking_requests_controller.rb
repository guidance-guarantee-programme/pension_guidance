module WelshLanguage
  class BookingRequestsController < ApplicationController
    include Embeddable

    helper MoneyHelper

    def new
      @booking_request = BookingRequest.new(booking_request_params)
    end

    def create
      @booking_request = BookingRequest.new(booking_request_params)

      if @booking_request.valid?
        WelshLanguage.create_booking(@booking_request)

        redirect_to completed_booking_requests_path
      else
        render :new
      end
    end

    def completed
    end

    def alternate_locales
      []
    end

    def default_locale?
      true
    end

    def alternate_url(new_locale, options = {})
      options[:locale] = new_locale

      root_url(options)
    end

    private

    def booking_request_params # rubocop:disable Metrics/MethodLength
      munge_date_params!

      params
        .fetch(:booking_request, {})
        .permit(
          :booking_type,
          :first_name,
          :last_name,
          :email,
          :phone,
          :memorable_word,
          :date_of_birth,
          :defined_contribution_pot_confirmed,
          :accessibility_needs,
          :adjustments,
          :additional_info,
          :where_you_heard,
          :gdpr_consent
        )
    end

    def munge_date_params!
      if booking_params = params[:booking_request] # rubocop:disable Lint/AssignmentInCondition, Style/GuardClause
        year  = booking_params.delete('date_of_birth(1i)')
        month = booking_params.delete('date_of_birth(2i)')
        day   = booking_params.delete('date_of_birth(3i)')

        booking_params[:date_of_birth] = "#{year}-#{month}-#{day}" if year && month && day
      end
    end
  end
end
