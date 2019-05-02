module Pages
  class EmployerBookingConfirmation < SitePrism::Page
    set_url '/{locale}/employers/{employer_id}/locations/{location_id}/bookings/confirmation'

    element :booking_reference, '.t-booking-reference'
    element :start, '.t-start'
    element :location, '.t-location'
  end
end
