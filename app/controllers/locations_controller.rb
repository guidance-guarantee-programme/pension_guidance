class LocationsController < ApplicationController
  NEAREST_LIMIT = 5

  before_action :set_breadcrumbs
  before_action :set_postcode
  before_action :send_cache_headers

  layout 'full_width_with_breadcrumbs', only: %i(show index)

  def index
    if @postcode.nil?
      locations = Locations::Repository.new.all

      @locations_by_letter = locations.group_by { |location| location.name.first }
      @locations_total     = locations.count

      render :a_to_z
    elsif @postcode.empty?
      render :empty_postcode
    else
      retrieve_locations
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

  def retrieve_locations
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
