Around('@booking_locations') do |_, block|
  require 'booking_locations/stub_api'

  begin
    previous_api = BookingLocations.api
    BookingLocations.api = BookingLocations::StubApi.new
    block.call
  ensure
    BookingLocations.api = previous_api
  end
end
