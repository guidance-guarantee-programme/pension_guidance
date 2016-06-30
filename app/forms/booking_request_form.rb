class BookingRequestForm
  include ActiveModel::Model

  attr_accessor :location_id, :primary_slot, :secondary_slot, :tertiary_slot,
                :first_name, :last_name, :email, :telephone_number,
                :memorable_word, :appointment_type, :accessibility_requirements,
                :opt_in, :dc_pot

  def initialize(location_id, opts)
    @location_id = location_id
    super(opts)
  end

  def slots_for_calendar
    @slots_for_calendar ||= booking_location.slots.map(&:to_calendar)
  end

  def booking_location
    @booking_location ||= BookingLocations.find(location_id)
  end
end
