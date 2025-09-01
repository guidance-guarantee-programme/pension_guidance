module Pages
  class TelephoneAppointmentConfirmation < SitePrism::Page
    element :booking_reference, '.t-booking-reference'
    element :extended_duration, '.t-extended-duration'
    element :start, '.t-start'
  end
end
