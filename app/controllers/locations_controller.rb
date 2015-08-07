class LocationsController < ApplicationController
  layout 'locations'

  before_action :set_breadcrumbs
  before_action :send_cache_headers

  def index
    return render :search unless params[:postcode].present?

    @postcode = params[:postcode]
    @locations = locations.map do |location|
      LocationSearchResultDecorator.new(location)
    end

  rescue Geocoder::InvalidPostcode
    render :invalid_postcode
  end

  def show
    location = Locations.find(params[:id])

    fail(ActionController::RoutingError, 'Location Not Found') unless location

    @postcode = params[:postcode]

    booking_location = if location.booking_location_id.present?
                         Locations.find(location.booking_location_id)
                       end
    twilio_number = Switchboard.lookup(params[:id])

    @location = LocationDecorator.new(location,
                                      booking_location: booking_location,
                                      twilio_number: twilio_number)
  end

  private

  def locations
    Locations.nearest_to_postcode(params[:postcode], limit: 5)
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_an_appointment
    breadcrumb Breadcrumb.how_to_book
  end

  def send_cache_headers
    expires_in Rails.application.config.cache_max_age, public: true
  end
end
