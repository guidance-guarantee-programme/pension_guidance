class TelephoneBookingController < ApplicationController
  layout 'full_width'

  before_action :set_breadcrumbs

  def step_one
    file = File.read('spec/fixtures/telephone_availability.json')
    availability = JSON.parse(file)
    @data = file.html_safe

    @available_days = availability.keys.map { |x| Date.parse(x) }.sort

    set_vars
  end

  def set_vars
    first_available_slot = @available_days.first
    beginning_of_month = first_available_slot.beginning_of_month
    end_of_month = first_available_slot.end_of_month

    @month = beginning_of_month.strftime('%B')

    @days = (beginning_of_month..end_of_month)

    @day_of_the_week = beginning_of_month.strftime('%u').to_i

    @selected_date = Date.parse(params[:date]) if params[:date]
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_a_telephone_appointment
  end
end
