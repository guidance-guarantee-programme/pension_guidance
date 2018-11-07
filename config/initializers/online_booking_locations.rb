if Rails.env.development? && !ENV['BOOKING_LOCATIONS_API_URI']
  require 'booking_locations/stub_api'
  BookingLocations.api = BookingLocations::StubApi.new
else
  BookingLocations.cache = Rails.cache
end
