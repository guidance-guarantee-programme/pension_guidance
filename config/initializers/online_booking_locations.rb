# Corresponding location ID(s)
Locations.online_booking_location_uids = ENV.fetch('BOOKING_LOCATION_UIDS', '').split(',')

# Booking Locations API adapter
BookingLocations.api = if Rails.env.development?
                         require 'booking_locations/stub_api'
                         BookingLocations::StubApi.new
                       else
                         BookingLocations::Api.new
                       end
