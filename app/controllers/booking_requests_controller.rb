class BookingRequestsController < ApplicationController
  def new
    @booking_location = BookingLocations.find(params[:location_id])
  end
end
