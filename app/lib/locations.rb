module Locations
  class << self
    attr_accessor :geo_json_path_or_url
  end

  def self.nearest_to_postcode(postcode, # rubocop:disable Metrics/ParameterLists
                               geocoder: Geocoder,
                               repository: Locations::Repository.new,
                               search: Locations::Search,
                               limit: nil,
                               radius: nil)
    lat_lng = geocoder.lookup(postcode)
    locations = repository.all

    search.nearest_to(locations, lat_lng, limit: limit, radius: radius)
  end

  def self.find(id, repository: Locations::Repository.new)
    repository.find(id)
  end
end
