class LocationsController < ApplicationController
  layout 'full_width'

  def index
    return redirect_to(appointments_path) unless params[:postcode].present?

    @locations = locations.map do |location|
      SearchResultDecorator.new(location)
    end
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
