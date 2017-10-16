module Pages
  class TescoBookingConfirmation < SitePrism::Page
    set_url '/{locale}/tesco/locations/{location_id}/bookings/confirmation'

    element :booking_reference, '.t-booking-reference'
    element :start, '.t-start'
    element :location, '.t-location'
  end
end
