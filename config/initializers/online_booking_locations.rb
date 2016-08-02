# Hackney and its associated locations
# Dalston
# Enfield
# Haringey
# Newham
# Tower Hamlets
Locations.online_booking_location_uids = %w(
  ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef
  183080c6-642b-4b8f-96fd-891f5cd9f9c7
  1cc67bbb-b879-4def-8713-99255a0bce03
  c165d25e-f27b-4ce9-b3d3-e7415ebaa93c
  89821b79-b132-4893-bc9f-c247dd9009fd
  1a1ad00f-d967-448a-a4a6-772369fa5087
)

# Booking Locations API adapter
BookingLocations.api = if Rails.env.development?
                         require 'booking_locations/stub_api'
                         BookingLocations::StubApi.new
                       else
                         require 'cached_booking_locations_api'
                         CachedBookingLocationsApi.new
                       end
