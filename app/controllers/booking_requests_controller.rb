class BookingRequestsController < ApplicationController
  layout 'full_width'

  def step_one
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)
    @booking_feedback = BookingFeedbackForm.new
  end

  def step_two
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)
    @booking_feedback = BookingFeedbackForm.new

    render :step_one unless @booking_request.step_one_valid?
  end

  def complete
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)
    @booking_feedback = BookingFeedbackForm.new

    if @booking_request.step_two_valid?
      BookingRequests.create(@booking_request)
      redirect_to booking_request_completed_location_path(id: location_id)
    else
      return redirect_to booking_request_ineligible_location_path(id: location_id) unless @booking_request.eligible?

      render :step_two
    end
  end

  def completed
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)
  end

  def ineligible
    @booking_request = BookingRequestForm.new(location_id, booking_request_params)
    @booking_feedback = BookingFeedbackForm.new
  end

  private

  def location_id
    params[:id]
  end
  helper_method :location_id

  def booking_request_params # rubocop:disable Metrics/MethodLength
    munge_date_params!

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
        :date_of_birth,
        :accessibility_requirements,
        :opt_in,
        :dc_pot
      )
  end

  def munge_date_params!
    booking_params = params[:booking_request]

    if booking_params
      year  = booking_params.delete('date_of_birth(1i)')
      month = booking_params.delete('date_of_birth(2i)')
      day   = booking_params.delete('date_of_birth(3i)')
    end

    booking_params[:date_of_birth] = "#{year}-#{month}-#{day}" if year && month && day
  end
end
