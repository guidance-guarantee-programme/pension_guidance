Locations.online_booking_location_uids = [
  # Corresponding location ID(s)
]

# Booking Locations API adapter
BookingLocations.api = if Rails.env.development?
                         require 'booking_locations/stub_api'
                         BookingLocations::StubApi.new
                       else
                         BookingLocations::Api.new
                       end
