module Pages
  class TelephoneAppointmentCancellation < SitePrism::Page
    set_url '/en/telephone-appointments/cancel/new'

    element :errors, '.t-errors'
    element :booking_reference, '.t-booking-reference'
    element :date_of_birth_day, '.t-date-of-birth-day'
    element :date_of_birth_month, '.t-date-of-birth-month'
    element :date_of_birth_year, '.t-date-of-birth-year'
    element :reason, '.t-reason'
    element :submit, '.t-submit'
  end
end
