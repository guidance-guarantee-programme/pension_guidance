class BookingRequestsController < ApplicationController
  layout 'full_width'

  def step_one
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)
  end

  def step_two
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)
  end

  def complete
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)
    BookingRequests.create(@booking_request)

    redirect_to booking_request_completed_location_path(id: location_id)
  end

  def completed
  end

  private

  def location_id
    params[:id]
  end
  helper_method :location_id

  def booking_request_params # rubocop:disable Metrics/MethodLength
    params
      .fetch(:booking_request, {})
      .permit(
        :primary_slot,
        :secondary_slot,
        :tertiary_slot,
        :first_name,
        :last_name,
        :email,
        :telephone_number,
        :memorable_word,
        :appointment_type,
        :accessibility_requirements,
        :opt_in,
        :dc_pot
      )
  end
end
