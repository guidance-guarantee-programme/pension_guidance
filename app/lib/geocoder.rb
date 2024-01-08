class Geocoder
  InvalidPostcode = Class.new(StandardError)
  FailedLookup = Class.new(StandardError)

  def self.lookup(postcode)
    ukp = UKPostcode.parse(postcode)
    raise InvalidPostcode unless ukp.full_valid?

    lookup = perform_lookup(postcode)
    raise InvalidPostcode unless lookup

    [lookup.latitude, lookup.longitude]
  end

  def self.perform_lookup(postcode)
    Postcodes::IO.new.lookup(postcode)
  rescue StandardError
    raise FailedLookup
  end
end
