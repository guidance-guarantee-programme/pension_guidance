if Rails.env.development?
  require 'booking_locations/stub_api'
  BookingLocations.api = BookingLocations::StubApi.new
else
  BookingLocations.cache = Rails.cache
end
