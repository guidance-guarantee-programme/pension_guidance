module Tesco
  class LocationsController < ApplicationController
    layout 'full_width_with_breadcrumbs'

    before_action :set_breadcrumbs

    def index
      @locations = Tesco.locations
    end

    private

    def set_breadcrumbs
      breadcrumb Breadcrumb.book_an_appointment
      breadcrumb Breadcrumb.tesco_locations
    end
  end
end
