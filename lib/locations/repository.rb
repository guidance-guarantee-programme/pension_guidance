module Locations
  class Repository
    def initialize(path = Locations.path)
      json = open(path)
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
        Location.new(
          feature.properties['title'],
          feature.properties['address'],
          feature.properties['phone'],
          feature.properties['hours'],
          [feature.geometry.y, feature.geometry.x]
        )
      end
    end
  end
end
