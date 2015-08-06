class LocationsController < ApplicationController
  layout 'locations'

  def index
    expires_in Rails.application.config.cache_max_age, public: true

    return render :search unless params[:postcode].present?

    @postcode = params[:postcode]
    @locations = locations.map do |location|
      SearchResultDecorator.new(location)
    end

  rescue Geocoder::InvalidPostcode
    render :invalid_postcode
  end

  def show
    location = Locations.find(params[:id])

    expires_in Rails.application.config.cache_max_age, public: true

    fail(ActionController::RoutingError, 'Location Not Found') unless location

    response = Excon.new("http://0.0.0.0:8080/lookup?id=#{params[:id]}").get
    if response.status == 200
      twilio_number = response.body
    end

    if location.booking_location_id.present?
      booking_location = Locations.find(location.booking_location_id)
      booking_location.phone = twilio_number if twilio_number
      @location = LocationDecorator.new(location, booking_location)
    else
      location.phone = twilio_number if twilio_number
      @location = LocationDecorator.new(location)
    end
  end

  private

  def locations
    Locations.nearest_to_postcode(params[:postcode], limit: 5)
  end
end
