class LocationsController < ApplicationController
  def index
    @locations = Locations.nearest_to_postcode(params[:postcode], limit: 5)
  end
end
