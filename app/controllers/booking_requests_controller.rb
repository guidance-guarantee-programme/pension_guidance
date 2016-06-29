class BookingRequestsController < ApplicationController
  layout 'full_width'

  def step_one
    @booking_request = BookingRequestForm.new(booking_request_params)
  end

  def step_two
    head :ok
  end

  private

  def booking_request_params
    @location_id = params.delete(:id)

    params
      .fetch(:booking_request, {})
      .permit(
        :primary_slot,
        :secondary_slot,
        :tertiary_slot
      ).merge(location_id: @location_id)
  end
end
