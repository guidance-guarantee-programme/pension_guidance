module Pages
  class TelephoneAppointmentCancellationSuccess < SitePrism::Page
    set_url '/en/telephone-appointments/cancel/success'

    element :rebook_link, '.t-rebook-link'
  end
end
