class BookingRequestsController < ApplicationController
  layout 'full_width'

  before_action :set_booking_request
  before_action :set_breadcrumbs

  def step_one
    raise(ActionController::RoutingError, 'Location Not Found') unless @booking_request.location

    if @booking_request.no_availability?
      render :no_availability
    else
      @locations = @booking_request.alternate_locations if @booking_request.limited_availability?

      retrieve_slots

      render :step_one
    end
  end

  def step_two
    retrieve_slots

    return render partial: 'times', locals: { times: @times } if request.xhr?

    render :step_one unless @booking_request.step_one_valid?
  end

  def complete
    if @booking_request.step_two_invalid?
      render :step_two
    elsif @booking_request.ineligible?
      redirect_to booking_request_ineligible_location_path(id: location_id)
    elsif result = BookingRequests.create(@booking_request) # rubocop:disable AssignmentInCondition
      redirect_to booking_request_completed_location_path(id: location_id), flash: result
    else
      redirect_to booking_request_step_one_location_path(id: location_id),
                  alert: 'The slot was taken. Please choose another slot.'
    end
  end

  def completed
  end

  def ineligible
  end

  private

  def retrieve_slots
    slots   = @booking_request.slots

    @months = retrieve_months(slots)
    @times  = retrieve_times(slots)
  end

  def retrieve_months(slots)
    default_months = Hash.new { |h, k| h[k] = [] }
    available_days = slots.keys.map(&:to_date)

    available_days.each_with_object(default_months) do |day, months|
      months[day.beginning_of_month] << day
    end
  end

  def retrieve_times(slots)
    return unless @booking_request.selected_date

    key = @booking_request.selected_date.strftime('%Y-%m-%d')

    Array(slots[key]).map { |d| DateTime.parse(d).in_time_zone }
  end

  def location_id
    params[:id]
  end
  helper_method :location_id

  def booking_request_params # rubocop:disable Metrics/MethodLength
    munge_date_params!

    params
      .fetch(:booking_request, {})
      .permit(
        :start_at,
        :selected_date,
        :first_name,
        :last_name,
        :email,
        :telephone_number,
        :memorable_word,
        :date_of_birth,
        :accessibility_requirements,
        :dc_pot,
        :additional_info,
        :where_you_heard,
        :gdpr_consent
      ).merge(remote_ip: request.remote_ip)
  end

  def munge_date_params!
    booking_params = params[:booking_request]

    if booking_params
      year  = booking_params.delete('date_of_birth(1i)')
      month = booking_params.delete('date_of_birth(2i)')
      day   = booking_params.delete('date_of_birth(3i)')
    end

    booking_params[:date_of_birth] = "#{year}-#{month}-#{day}" if year && month && day
  end

  def set_booking_request
    @booking_request ||= BookingRequestForm.new(location_id, booking_request_params)
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_an_appointment
    breadcrumb Breadcrumb.how_to_book_face_to_face
    breadcrumb Breadcrumb.book_online(location_id, @booking_request.location_name)
  end
end
