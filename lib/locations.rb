module Locations
  class << self
    attr_accessor :path
  end

  def self.nearest_to_postcode(postcode,
      geocoder: Postcodes::IO.new, repository: Repository.new, search: Search, limit:)
    lookup = geocoder.lookup(postcode)
    lat_lng = [lookup.latitude, lookup.longitude]

    locations = repository.all

    search.nearest_to(locations, lat_lng, limit)
  end
end
