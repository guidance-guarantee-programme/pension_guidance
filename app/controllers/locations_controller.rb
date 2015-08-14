class LocationsController < ApplicationController
  NEAREST_LIMIT = 5

  before_action :set_breadcrumbs
  before_action :set_postcode
  before_action :send_cache_headers

  def index
    return render :search unless @postcode.present?

    @locations = begin
      Locations.nearest_to_postcode(@postcode, limit: NEAREST_LIMIT).map do |location|
        LocationSearchResultDecorator.new(location)
      end
    rescue Geocoder::InvalidPostcode
      render :invalid_postcode
    end
  end

  def show
    location = Locations.find(params[:id])

    fail(ActionController::RoutingError, 'Location Not Found') unless location

    booking_location = Locations.find(location.booking_location_id) if location.booking_location_id.present?
    nearest_locations = Locations.nearest_to_postcode(@postcode, limit: NEAREST_LIMIT) rescue nil
    twilio_number = Switchboard.lookup(params[:id])

    @location = LocationDecorator.new(location,
                                      booking_location: booking_location,
                                      nearest_locations: nearest_locations,
                                      twilio_number: twilio_number)
  end

  private

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_an_appointment
    breadcrumb Breadcrumb.how_to_book
  end

  def set_postcode
    @postcode = params[:postcode]
  end

  def send_cache_headers
    expires_in Rails.application.config.cache_max_age, public: true
  end
end
