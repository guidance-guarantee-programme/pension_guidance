class BookingRequestsController < ApplicationController
  layout 'full_width'

  def new
    @booking_request = BookingRequest.create

    @primary_slot = @booking_request.build_primary_slot
    @secondary_slot = @booking_request.build_secondary_slot
    @tertiary_slot = @booking_request.build_tertiary_slot
  end

  def create
  end
end
