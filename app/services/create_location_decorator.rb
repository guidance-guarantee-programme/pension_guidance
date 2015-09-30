class CreateLocationDecorator
  def self.build(location:, postcode:, search_limit:)
    booking_location = Locations.find(location.booking_location_id) if location.booking_location_id.present?
    nearest_locations = Locations.nearest_to_postcode(postcode, limit: search_limit) rescue nil
    search_context = LocationSearchContext.build(nearest_locations, location)
    twilio_number = Switchboard.lookup(location.id)

    LocationDecorator.new(location,
                          booking_location: booking_location,
                          search_context: search_context,
                          twilio_number: twilio_number)
  end
end
