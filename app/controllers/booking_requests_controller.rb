class BookingRequestsController < ApplicationController
  layout 'full_width'

  def step_one
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)
  end

  def step_two
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)

    render :step_one unless @booking_request.step_one_valid?
  end

  def complete
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)

    if @booking_request.step_two_valid_excluding_eligibility?
      return redirect_to booking_request_ineligible_location_path(id: location_id) unless @booking_request.eligible?

      BookingRequests.create(@booking_request)
      redirect_to booking_request_completed_location_path(id: location_id)
    else
      render :step_two
    end
  end

  def completed
  end

  def ineligible
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
