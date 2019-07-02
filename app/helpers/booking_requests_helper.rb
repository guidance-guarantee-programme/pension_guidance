module BookingRequestsHelper
  def confirmation
    partial = flash[:reference] ? 'appointment_confirmation' : 'booking_request_confirmation'

    render partial: partial
  end
end
