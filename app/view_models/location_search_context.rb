class LocationSearchContext
  attr_accessor :distance, :position

  def initialize(distance: nil, position: nil)
    self.distance = distance
    self.position = position
  end
end
