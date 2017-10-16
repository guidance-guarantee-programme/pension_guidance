module Tesco
  cattr_accessor :api

  def self.locations
    api.locations.map { |location| Location.new(location) }
  end

  def self.location(location_id)
    response = api.location(location_id)

    Location.new(response)
  end

  def self.create(booking)
    api.create(booking)
  end
end
