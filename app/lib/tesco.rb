module Tesco
  cattr_accessor :api

  def self.locations
    api.locations.map { |location| Location.new(location) }
  end
end
