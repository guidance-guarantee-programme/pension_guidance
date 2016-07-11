module Pages
  class BookingComplete < SitePrism::Page
    set_url '/locations/{id}/booking-request/complete'

    element :error, '.t-errors'
  end
end
