module Pages
  class NudgeAppointmentConfirmation < SitePrism::Page
    set_url '/en/nudge-appointments/confirmation'

    element :booking_reference, '.t-booking-reference'
  end
end
