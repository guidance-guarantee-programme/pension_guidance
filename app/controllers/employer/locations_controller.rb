module Employer
  class LocationsController < ApplicationController
    layout 'full_width_with_breadcrumbs'

    before_action :set_breadcrumbs

    def index
      expires_in Rails.application.config.cache_max_age, public: true

      @locations_by_letter = locations.group_by(&:name)
      @locations_total     = locations.count
    end

    def show
      @location = ::Employer.location(params[:id])
    end

    private

    def employer_id
      params[:employer_id]
    end
    helper_method :employer_id

    def employer
      @employer ||= ::Employer.employer(employer_id)
    end
    helper_method :employer

    def locations
      @locations ||= employer.locations
    end

    def set_breadcrumbs
      breadcrumb Breadcrumb.employer_locations(employer_id, employer.name)
    end
  end
end
