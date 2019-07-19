module Locations
  class Repository
    def initialize(geo_json_path_or_url = Locations.geo_json_path_or_url)
      json = Locations::Reader.new(geo_json_path_or_url).call
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
        Locations::Location.new(*params_for_location(feature))
      end
    end

    def params_for_location(feature) # rubocop:disable Metrics/MethodLength
      [
        id: feature.feature_id,
        name: feature.property('title'),
        address: feature.property('address'),
        booking_location_id: feature.property('booking_location_id'),
        phone: feature.property('phone'),
        hours: feature.property('hours'),
        twilio_number: feature.property('twilio_number'),
        online_booking_enabled: feature.property('online_booking_enabled'),
        lat_lng: [feature.geometry.y, feature.geometry.x]
      ]
    end
  end
end
