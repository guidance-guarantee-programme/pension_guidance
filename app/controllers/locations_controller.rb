class LocationsController < ApplicationController
  NEAREST_LIMIT = 5

  before_action :set_breadcrumbs
  before_action :set_postcode
  before_action :send_cache_headers

  layout 'full_width', only: [:show]

  def index
    return render :search unless @postcode.present?

    @locations = begin
      Locations.nearest_to_postcode(@postcode, limit: NEAREST_LIMIT).map do |location|
        LocationSearchResultDecorator.new(location)
      end
    rescue Geocoder::InvalidPostcode
      render :invalid_postcode
    rescue Geocoder::FailedLookup
      render :failed_lookup
    end
  end

  def show
    location = Locations.find(params[:id])

    raise(ActionController::RoutingError, 'Location Not Found') unless location

    booking_location = Locations.find(location.booking_location_id) if location.booking_location_id.present?
    nearest_locations = Locations.nearest_to_postcode(@postcode, limit: NEAREST_LIMIT) rescue nil

    @location = LocationDecorator.new(location,
                                      booking_location: booking_location,
                                      nearest_locations: nearest_locations)
  end

  private

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_an_appointment
    breadcrumb Breadcrumb.how_to_book_face_to_face
  end

  def set_postcode
    @postcode = params[:postcode]
  end

  def send_cache_headers
    expires_in Rails.application.config.cache_max_age, public: true
  end
end
