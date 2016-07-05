module Pages
  class BookingStepOne < SitePrism::Page
    set_url '/locations/{id}/booking-request/step-one'

    element :location_name, '.t-location-name'
    element :first_chosen_slot, 'div:nth-child(1).SlotPicker-choice.is-chosen'
    element :last_chosen_slot, 'div:nth-child(3).SlotPicker-choice.is-chosen'
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
