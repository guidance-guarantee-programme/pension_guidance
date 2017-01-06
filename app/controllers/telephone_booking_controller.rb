class TelephoneBookingController < ApplicationController
  layout 'full_width'

  before_action :set_breadcrumbs

  def step_one

  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_a_telephone_appointment
  end
end
