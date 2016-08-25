# Hackney and associated locations
HACKNEY = %w(
  ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef
  183080c6-642b-4b8f-96fd-891f5cd9f9c7
  1cc67bbb-b879-4def-8713-99255a0bce03
  c165d25e-f27b-4ce9-b3d3-e7415ebaa93c
  89821b79-b132-4893-bc9f-c247dd9009fd
  1a1ad00f-d967-448a-a4a6-772369fa5087
).freeze

# Cardiff and Vale (Barry) and associated locations
CARDIFF_AND_VALE = %w(
  525da418-ff2c-4522-90a9-bc70ba4ca78b
  edde9cde-41ac-4485-9919-b6d34d79f844
  657a523b-f14f-46b9-9024-5b51ddcf1e8e
  26c38b1b-59e3-4c52-9390-ef3b644dd60a
  fa064037-1467-403a-a3ca-a963853e9f89
).freeze

Locations.online_booking_location_uids = HACKNEY + CARDIFF_AND_VALE

if Rails.env.development?
  require 'booking_locations/stub_api'
  BookingLocations.api = BookingLocations::StubApi.new
else
  BookingLocations.cache = Rails.cache
end
