module Locations
  class Search
    def self.nearest_to(locations, _lat_lng, limit)
      locations.take(limit)
    end
  end
end
