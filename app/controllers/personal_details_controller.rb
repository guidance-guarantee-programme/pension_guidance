class PersonalDetailsController < ApplicationController
  def new
    @booking_request = BookingRequest.find(params[:booking_request_id])
  end
end
