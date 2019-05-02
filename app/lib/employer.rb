module Employer
  cattr_accessor :api

  def self.employer(employer_id)
    response = api.employer(employer_id)

    ::Employer::Employer.new(response)
  end

  def self.location(location_id)
    response = api.location(location_id)

    Location.new(response)
  end

  def self.create(booking)
    api.create(booking)
  end
end
