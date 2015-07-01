require 'open-uri'

module Locations
  class Reader
    attr_accessor :path, :redis

    def initialize(path, redis = Redis.new)
      self.path = path
      self.redis = redis
    end

    def call
      if json_from_url?
        cached_json
      else
        read_json(path)
      end
    end

    private

    def json_from_url?
      path.to_s =~ /^http/
    end

    def cached_json
      json = redis.get('locations')
      unless json
        json = read_json(path)
        redis.setex('locations', locations_ttl, json)
      end
      json
    end

    def locations_ttl
      ENV['LOCATIONS_TTL'].to_i
    end

    def read_json(path)
      open(path).read
    end
  end
end
