class TelephoneBookingController < ApplicationController
  layout 'full_width'

  before_action :set_breadcrumbs

  def step_one
    file = File.read('spec/fixtures/telephone_availability.json')
    @availability = JSON.parse(file)
    @data = file

    @available_days = @availability.keys.map { |x| Date.parse(x) }.sort

    set_vars
  end

  def set_vars
    if params[:month]
      slot = Date.parse("#{params[:month]}-01")
    else
      slot = @available_days.first
    end

    beginning_of_month = slot.beginning_of_month
    end_of_month = slot.end_of_month

    @month = beginning_of_month.strftime('%B')
    @next_month = beginning_of_month.next_month.strftime('%B')
    @next_month_url_var = beginning_of_month.next_month.strftime('%Y-%m')

    @days = (beginning_of_month..end_of_month)

    @day_of_the_week = beginning_of_month.strftime('%u').to_i

    if params[:date]
      @selected_date = Date.parse(params[:date])
      @selected_date_formatted = @selected_date.strftime('%Y-%m-%d')
      @available_times = @availability[@selected_date.strftime('%Y-%m-%d')]
    end
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_a_telephone_appointment
  end
end
