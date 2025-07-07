module Pages
  class TelephoneAppointmentReschedulingFailure < SitePrism::Page
    set_url '/en/telephone-appointments/reschedule/failure'

    element :failure_notice, '.t-failure-notice'
  end
end
