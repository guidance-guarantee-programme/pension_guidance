require 'open-uri'

module Locations
  class Reader
    DEFAULT_TTL = 60

    attr_accessor :path, :redis_pool
    attr_reader :ttl

    def initialize(path, redis_pool = REDIS_POOL, ttl = ENV['LOCATIONS_TTL'])
      self.path = path
      self.redis_pool = redis_pool
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
      redis_pool.with do |redis|
        json = redis.get('locations')

        unless json
          json = read_json(path)
          redis.setex('locations', ttl, json)
        end

        return json
      end
    end

    def read_json(path)
      URI.open(path).read
    end
  end
end
