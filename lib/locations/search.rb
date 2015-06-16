module Locations
  class Search
    METRES_PER_MILE = 1609.344

    def self.nearest_to(locations, lat_lng, limit)
      start_point = point(lat_lng)

      search_results = locations.map do |location|
        end_point = point(location.lat_lng)
        distance = start_point.distance(end_point) / METRES_PER_MILE
        SearchResult.new(location, distance)
      end

      search_results.sort_by(&:distance).take(limit)
    end

    def self.point(lat_lng)
      RGeo::Geographic.spherical_factory.point(lat_lng[1], lat_lng[0])
    end
  end
end
