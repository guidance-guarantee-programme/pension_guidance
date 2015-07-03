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
    @location = Locations.find(params[:id])

    fail(ActionController::RoutingError, 'Location Not Found') unless @location

    expires_in Rails.application.config.cache_max_age, public: true
  end

  private

  def locations
    Locations.nearest_to_postcode(params[:postcode], limit: 5)
  end
end
