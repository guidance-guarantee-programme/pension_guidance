class LocationsController < ApplicationController
  layout 'locations'

  def index
    return render :invalid_postcode unless params[:postcode].present?
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
  end

  private

  def locations
    Locations.nearest_to_postcode(params[:postcode], limit: 5)
  end
end
