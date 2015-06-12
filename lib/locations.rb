module Locations
  class << self
    attr_accessor :path
  end

  def self.nearest_to_postcode(postcode,
      geocoder: Geocoder, repository: Repository.new, search: Search, limit:)
    lat_lng = geocoder.coordinates(postcode)
    locations = repository.all

    search.nearest_to(locations, lat_lng, limit)
  end
end
