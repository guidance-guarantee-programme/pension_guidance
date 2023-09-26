module Employer
  def self.employer(employer_id)
    response  = api.employer(employer_id)
    locations = response['locations'].map { |data| Location.new(data) }

    ::Employer::Employer.new(name: response['name'], locations: locations)
  end

  def self.location(location_id)
    response = api.location(location_id)

    Location.new(response)
  end

  def self.create(booking)
    api.create(booking)
  end

  def self.api
    @api ||= ::Employer::Api.new
  end

  def self.api=(api)
    @api = api
  end
end
