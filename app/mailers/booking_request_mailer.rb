class BookingRequestMailer < ApplicationMailer
  def customer_confirmation(booking_request)
    @booking_request = booking_request

    mail(
      to: @booking_request.email,
      subject: "Your Pension Guidance Booking: #{@booking_request.reference_number}"
    )
  end
end
