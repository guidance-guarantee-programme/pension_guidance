class LocationsController < ApplicationController
  NEAREST_LIMIT = 5

  before_action :set_breadcrumbs
  before_action :set_postcode
  before_action :send_cache_headers
  before_action :identify_agent
  skip_before_action :verify_authenticity_token

  layout 'full_width_with_breadcrumbs', only: %i(show search)

  def index
    locations = Locations::Repository.new.all

    @locations_by_letter = locations.group_by { |location| location.name.first }
    @locations_total     = locations.count
  end

  def search
    if @postcode.empty?
      render :empty_postcode
    else
      retrieve_locations
    end
  end

  def show
    location = Locations.find(params[:id])

    return redirect_to(locations_path(locale: locale), status: :moved_permanently) unless location

    booking_location = Locations.find(location.booking_location_id) if location.booking_location_id.present?

    @location = LocationDecorator.new(location, booking_location: booking_location)
  end

  private

  def agent?
    @agent
  end
  helper_method :agent?

  def identify_agent
    @agent = PlacedByAgent.new(request.remote_ip).call
  end

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
