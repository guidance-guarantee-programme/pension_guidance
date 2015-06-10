module Locations
  def self.nearest_to_postcode(postcode, limit:)
    lat_lng_for(postcode)

    [].take(limit)
  end

  private

  def self.lat_lng_for(postcode)
    Geocoder.coordinates(postcode)
  end
end
