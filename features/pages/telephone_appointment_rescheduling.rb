module Pages
  class TelephoneAppointmentRescheduling < SitePrism::Page
    set_url '/en/telephone-appointments/reschedule/new'

    element :errors, '.t-errors'
    element :booking_reference, '.t-booking-reference'
    element :date_of_birth_day, '.t-date-of-birth-day'
    element :date_of_birth_month, '.t-date-of-birth-month'
    element :date_of_birth_year, '.t-date-of-birth-year'
    element :reason, '.t-reason'
    element :submit, '.t-submit'

    section :current_appointment, '.t-current-appointment' do
      element :booking_reference, '.t-booking-reference'
      element :date, '.t-date'
      element :time, '.t-time'
    end

    section :new_appointment, '.t-new-appointment' do
      element :booking_reference, '.t-booking-reference'
      element :date, '.t-date'
      element :time, '.t-time'
      element :submit, '.t-submit'
    end

    element :continue, '.t-continue'

    def choose_date(date)
      find("button[value='#{date}']").click
    end

    def choose_time(time)
      find('label', text: time).click
    end
  end
end
