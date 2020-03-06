require_relative '../sections/feedback'

module Pages
  class BookingStepOne < Page
    set_url '/{locale}/locations/{id}/booking-request/step-one'

    element :location_name, '.t-location-name'
    element :continue, '.t-continue'
    element :phone, '.t-phone'

    elements :available_days, 'button:enabled.js-day-button'
    elements :time_slots, '.t-time'

    section :feedback, Sections::Feedback, '.t-feedback'

    def choose_date(date)
      page.click_on(date)
    end

    def choose_time(time)
      page.choose(time)
    end
  end
end
