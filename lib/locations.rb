module Locations
  def self.nearest_to_postcode(postcode,
      geocoder: Geocoder, repository: Repository, search: Search, limit:)
    lat_lng = geocoder.coordinates(postcode)
    locations = repository.all

    search.nearest_to(locations, lat_lng, limit)
  end
end
