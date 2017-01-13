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
    first_slot = @available_days.first
    last_slot = @available_days.last

    first_day = first_slot.beginning_of_month
    last_day = last_slot.end_of_month

    @months = (first_day..last_day).to_a.uniq do |day|
      day.strftime('%m')
    end.map do |day|
      (day.beginning_of_month..day.end_of_month).to_a
    end

    # beginning_of_month = slot.beginning_of_month
    # end_of_month = slot.end_of_month

    # @month = beginning_of_month.strftime('%B')
    # @month_url_var = beginning_of_month.strftime('%Y-%m')
    # @next_month = beginning_of_month.next_month.strftime('%B')
    # @next_month_url_var = beginning_of_month.next_month.strftime('%Y-%m')
    # @prev_month = beginning_of_month.prev_month.strftime('%B')
    # @prev_month_url_var = beginning_of_month.prev_month.strftime('%Y-%m')

    # @is_first_month = slot.strftime('%Y-%m') == @available_days.first.strftime('%Y-%m')
    # @is_last_month = slot.strftime('%Y-%m') == @available_days.last.strftime('%Y-%m')

    # @days = (beginning_of_month..end_of_month)

    # @day_of_the_week = beginning_of_month.strftime('%u').to_i

    # if params[:date]
    #   @selected_date = Date.parse(params[:date])
    #   @selected_date_formatted = @selected_date.strftime('%Y-%m-%d')
    #   @available_times = @availability[@selected_date.strftime('%Y-%m-%d')]
    # end
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_a_telephone_appointment
  end
end
