module Locations
  class SearchResult < SimpleDelegator
    attr_accessor :distance

    def initialize(location, distance)
      self.distance = distance
      super(location)
    end
  end
end
