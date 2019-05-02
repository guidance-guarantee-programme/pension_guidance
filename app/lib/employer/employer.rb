module Employer
  class Employer < OpenStruct
    def locations
      super.map { |location| Location.new(location) }
    end
  end
end
