require 'open-uri'

module Locations
  class Reader
    DEFAULT_TTL = 60

    attr_accessor :path, :redis
    attr_reader :ttl

    def initialize(path, redis = Redis.new, ttl = ENV['LOCATIONS_TTL'])
      self.path = path
      self.redis = redis
      self.ttl = ttl
    end

    def ttl=(ttl)
      @ttl = ttl.nil? ? DEFAULT_TTL : ttl.to_i
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
        redis.setex('locations', ttl, json)
      end

      json
    end

    def read_json(path)
      open(path).read
    end
  end
end
