class BookingRequestsController < ApplicationController
  layout 'full_width'

  def new
    @booking_location = BookingLocations.find(params[:location_id])
  end
end
