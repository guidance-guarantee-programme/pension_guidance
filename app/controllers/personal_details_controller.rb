class PersonalDetailsController < ApplicationController
  layout 'full_width'

  def new
    @booking_request = BookingRequest.find(params[:booking_request_id])
  end
end
