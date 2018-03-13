module Tesco
  class LocationsController < ApplicationController
    layout 'full_width_with_breadcrumbs'

    before_action :set_breadcrumbs

    def index
      expires_in Rails.application.config.cache_max_age, public: true

      @locations_by_letter = locations.group_by(&:name_index)
      @locations_total     = locations.count
    end

    def show
      @location = Tesco.location(params[:id])
    end

    private

    def locations
      @locations ||= Tesco.locations
    end

    def set_breadcrumbs
      breadcrumb Breadcrumb.tesco_landing_page
      breadcrumb Breadcrumb.tesco_locations
    end
  end
end
