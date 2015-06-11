module Locations
  class Search
    def self.nearest_to(locations, lat_lng, limit)
      search_results = locations.map do |location|
        distance = Geocoder::Calculations.distance_between(
          location.lat_lng, lat_lng, units: :mi)
        SearchResult.new(location, distance)
      end

      search_results.sort_by(&:distance).take(limit)
    end
  end
end
