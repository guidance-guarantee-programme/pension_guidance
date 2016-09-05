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
  d1695069-0eb2-409c-bcb1-1d8d176c92bc
  5623d4d2-45be-4e65-8b31-382959c8999f
  a76f84ed-f704-412b-9fb1-e90d95d528cf
  6a496a82-9f2a-448d-a785-2522327687f0
).freeze

# Taunton and associated locations
TAUNTON = %w(
  7f916cf6-d2bd-4bcc-90dc-594207c8b1f4
  43fcab23-b01f-4805-a34d-e7edb77b65ce
  fdf2fa41-b0b7-44ae-a992-4409490dc9fb
  05dbf9e9-662b-4b10-ad85-70c38bd08d6d
  13e12f95-f709-4536-b6ee-8d7a735ddf9f
  ca857ea1-e51a-442d-937d-b7c720d91ecf
  90bebb70-c4bb-4572-afb2-e4ede5ca38c9
  b5920e4c-ac91-49c3-8923-3efd10292db2
).freeze

Locations.online_booking_location_uids = HACKNEY + CARDIFF_AND_VALE + TAUNTON

if Rails.env.development?
  require 'booking_locations/stub_api'
  BookingLocations.api = BookingLocations::StubApi.new
else
  BookingLocations.cache = Rails.cache
end
