module Pages
  class BookingComplete < Page
    set_url '/{locale}/locations/{id}/booking-request/complete'

    element :error, '.t-errors'
  end
end
