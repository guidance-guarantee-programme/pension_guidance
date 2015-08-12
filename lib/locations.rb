module Locations
  class << self
    attr_accessor :geo_json_path_or_url
  end

  def self.nearest_to_postcode(postcode, geocoder: Geocoder,
                                         repository: Locations::Repository.new,
                                         search: Locations::Search,
                                         limit:)
    lat_lng = geocoder.lookup(postcode)
    locations = repository.all

    search.nearest_to(locations, lat_lng, limit)
  end

  def self.find(id, repository: Locations::Repository.new)
    repository.find(id)
  end
end
