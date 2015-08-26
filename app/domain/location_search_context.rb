class LocationSearchContext
  attr_accessor :distance, :position

  def self.build(search_results, location)
    return unless search_results.present?

    index = search_results.index { |result| result.id == location.id }
    distance = format('%.2f', search_results[index].distance)
    position = index + 1

    new(distance, position)
  end

  def initialize(distance, position)
    self.distance = distance
    self.position = position
  end
end
