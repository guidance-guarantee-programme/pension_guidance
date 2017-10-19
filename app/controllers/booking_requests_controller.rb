class BookingRequestsController < ApplicationController
  layout 'full_width'

  before_action :set_booking_request
  before_action :set_breadcrumbs

  def step_one
    @feedback = FeedbackForm.for_online_booking

    if @booking_request.no_availability?
      render :no_availability
    else
      if @booking_request.limited_availability?
        @locations = @booking_request.alternate_locations
      end

      render :step_one
    end
  end

  def step_two
    @feedback = FeedbackForm.for_online_booking

    render :step_one unless @booking_request.step_one_valid?
  end

  def complete
    @feedback = FeedbackForm.for_online_booking

    if @booking_request.step_two_invalid?
      render :step_two
    elsif @booking_request.ineligible?
      redirect_to booking_request_ineligible_location_path(id: location_id)
    else
      BookingRequests.create(@booking_request)
      redirect_to booking_request_completed_location_path(id: location_id)
    end
  end

  def completed
  end

  def ineligible
    @feedback = FeedbackForm.for_online_booking
  end

  private

  def location_id
    params[:id]
  end
  helper_method :location_id

  def booking_request_params # rubocop:disable Metrics/MethodLength
    munge_date_params!

    params
      .fetch(:booking_request, {})
      .permit(
        :primary_slot,
        :secondary_slot,
        :tertiary_slot,
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
        :opt_in
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
