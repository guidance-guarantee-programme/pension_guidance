require_relative '../sections/feedback'

module Pages
  class BookingStepOne < Page
    set_url '/{locale}/locations/{id}/booking-request/step-one'

    element :location_name, '.t-location-name'
    element :continue, '.t-continue'
    element :phone, '.t-phone'

    elements :available_days, '.BookingCalendar-date--bookable'
    elements :time_slots, '.SlotPicker-day.is-active > label'
    elements :chosen_slots, '.SlotPicker-choice.is-chosen'
    elements :slot_options, '.SlotPicker-choice'

    section :feedback, Sections::Feedback, '.t-feedback'

    def morning_slot
      wait_for_time_slots
      time_slots.first
    end

    def afternoon_slot
      wait_for_time_slots
      time_slots.last
    end
  end
end
