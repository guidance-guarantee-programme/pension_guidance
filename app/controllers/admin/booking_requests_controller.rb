class Admin::BookingRequestsController < ApplicationController
  layout 'full_width'

  def index
    @booking_requests = BookingRequest.last(50).reverse
  end
end
