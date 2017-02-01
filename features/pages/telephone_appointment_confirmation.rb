module Pages
  class TelephoneAppointmentConfirmation < SitePrism::Page
    element :booking_reference, '.t-booking-reference'
    element :start, '.t-start'
  end
end
