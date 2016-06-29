class BookingRequestForm
  include ActiveModel::Model

  attr_accessor :location_id, :primary_slot, :secondary_slot, :tertiary_slot

  def slots_for_calendar
    @slots_for_calendar ||= booking_location.slots.map(&:to_calendar)
  end

  def booking_location
    @booking_location ||= BookingLocations.find(location_id)
  end
end
