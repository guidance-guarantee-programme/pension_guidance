module BookingLocations
  class Location
    def initialize(data)
      @data = data
    end

    def id
      @data['uid']
    end

    def name
      @data['name']
    end

    def address
      @data['address']
    end

    def locations
      @locations ||= @data['locations'].map { |child_data| Location.new(child_data) }
    end

    def guiders
      @guiders ||= @data['guiders'].map { |guider| OpenStruct.new(guider) }
    end

    def slots
      @slots ||= @data['slots'].map { |slot| OpenStruct.new(slot) }
    end
  end
end
