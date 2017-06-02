module Locations
  class Search
    METRES_PER_MILE = 1609.344

    def self.nearest_to(locations, lat_lng, radius: nil, limit: nil)
      start_point = point(lat_lng)

      search_results = locations.each_with_object([]) do |location, memo|
        end_point = point(location.lat_lng)
        distance = start_point.distance(end_point) / METRES_PER_MILE

        if radius.nil? || distance <= radius
          memo << SearchResult.new(location, distance)
        end
      end

      search_results = search_results.sort_by(&:distance)

      limit.present? ? search_results.take(limit) : search_results
    end

    def self.point(lat_lng)
      RGeo::Geographic.spherical_factory.point(lat_lng[1], lat_lng[0])
    end
  end
end
