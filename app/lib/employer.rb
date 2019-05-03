module Employer
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

  def self.api
    @api ||= Employer::Api.new
  end

  def self.api=(api)
    @api = api
  end
end
