require 'open-uri'

module Locations
  class Repository
    def initialize(geo_json_path_or_url = Locations.geo_json_path_or_url)
      json = open(geo_json_path_or_url).read
      features = RGeo::GeoJSON.decode(json, json_parser: :json)

      self.locations = map_features(features)
    end

    def all
      locations
    end

    def find(id)
      locations.find { |location| location.id == id }
    end

    private

    attr_accessor :locations

    def map_features(features)
      features.map do |feature|
        Location.new(*params_for_location(feature))
      end
    end

    def params_for_location(feature)
      [
        feature.feature_id,
        feature.properties['title'],
        feature.properties['address'],
        feature.properties['booking_location_id'],
        feature.properties['phone'],
        feature.properties['hours'],
        [feature.geometry.y, feature.geometry.x]
      ]
    end
  end
end
