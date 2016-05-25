class BookingRequestsController < ApplicationController
  layout 'full_width'

  def new
    @booking_request = BookingRequest.create

    @primary_slot = @booking_request.build_primary_slot
    @secondary_slot = @booking_request.build_secondary_slot
    @tertiary_slot = @booking_request.build_tertiary_slot
  end

  def update
    @booking_request = BookingRequest.find(params[:id])
    @booking_request.slots_from(booking_request_params)
    @booking_request.save!

    redirect_to new_booking_request_personal_detail_path(@booking_request)
  end

  private

  def booking_request_params
    params
      .require(:booking_request)
      .permit(
        :primary_slot,
        :secondary_slot,
        :tertiary_slot
      )
  end
end
