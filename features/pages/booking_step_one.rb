module Pages
  class BookingStepOne < SitePrism::Page
    set_url '/locations/{id}/booking-request/step-one'

    element :continue, '.t-continue'

    elements :available_days, '.BookingCalendar-date--bookable'
    elements :time_slots, '.SlotPicker-day.is-active > label'

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
