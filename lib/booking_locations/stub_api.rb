module BookingLocations
  KNOWN_LOCATION_IDS = %w(
    ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef
    183080c6-642b-4b8f-96fd-891f5cd9f9c7
    c165d25e-f27b-4ce9-b3d3-e7415ebaa93c
    a77a031a-8037-4510-b1f7-63d4aab7b103
  ).freeze

  class StubApi
    def get(id)
      return nil unless KNOWN_LOCATION_IDS.include?(id)

      contents = IO.read(Rails.root.join(*%w(lib booking_locations stub_api.json)))
      yield JSON.parse(contents)
    end
  end
end
