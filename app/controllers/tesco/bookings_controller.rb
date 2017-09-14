# rubocop:disable Metrics/ClassLength
module Tesco
  class BookingsController < ApplicationController
    layout 'full_width'

    before_action :booking
    before_action :retrieve_slots
    before_action :set_breadcrumbs

    def new
    end

    def create
      send("create_step_#{booking.step}")
    end

    def confirmation
      return redirect_to root_path unless params[:booking_reference]

      @booking_reference = params[:booking_reference]
      @booking_date      = Time.zone.parse(params[:booking_date])
    end

    private

    def create_step_1
      booking.advance! { render :new }
    end

    def create_step_2
      if request.xhr?
        render partial: 'times', locals: { times: @times }
      elsif slot_selected?
        booking.advance! { render :new }
      else
        render :new
      end
    end

    def create_step_3 # rubocop:disable Metrics/AbcSize
      if booking.invalid?
        render :new
      elsif booking.ineligible?
        redirect_to ineligible_tesco_location_bookings_path(location_id: location_id)
      elsif booking.save
        confirm_to_customer(booking)
      else
        @slot_assignment_failed = true
        booking.reset! { render :new }
      end
    end

    def confirm_to_customer(booking)
      redirect_to confirmation_tesco_location_bookings_path(
        location_id: location_id,
        booking_reference: booking.id,
        booking_date: booking.start_at
      )
    end

    def retrieve_slots
      @months ||= retrieve_months(location.windowed_slots)
      @times  ||= retrieve_times(location.windowed_slots)
    end

    def location_id
      params[:location_id]
    end
    helper_method :location_id

    def location
      @location ||= Tesco.location(location_id)
    end

    def booking
      @booking ||= Tesco::Booking.new(booking_params)
    end

    def booking_params # rubocop:disable Metrics/MethodLength
      params
        .fetch(:booking, {})
        .permit(
          :step,
          :selected_date,
          :start_at,
          :first_name,
          :last_name,
          :email,
          :phone,
          :memorable_word,
          :date_of_birth,
          :dc_pot_confirmed,
          :opt_out_of_market_research,
          :accept_terms_and_conditions,
          :date_of_birth_year,
          :date_of_birth_month,
          :date_of_birth_day
        ).merge(location_id: location_id)
    end

    def slot_selected?
      booking.start_at
    end
    helper_method :slot_selected?

    def retrieve_months(slots)
      default_months = Hash.new { |h, k| h[k] = [] }
      available_days = slots.keys.map(&:to_date)

      available_days.each_with_object(default_months) do |day, months|
        months[day.beginning_of_month] << day
      end
    end

    def retrieve_times(slots)
      return unless booking.selected_date

      key = booking.selected_date.strftime('%Y-%m-%d')

      Array(slots[key]).map { |d| DateTime.parse(d).in_time_zone }
    end

    def set_breadcrumbs
      breadcrumb Breadcrumb.tesco_landing_page
      breadcrumb Breadcrumb.tesco_locations
      breadcrumb Breadcrumb.tesco_location(location.id, location.name)
    end
  end
end
