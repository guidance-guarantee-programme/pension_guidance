class TelephoneAppointmentsController < ApplicationController
  layout 'full_width'

  before_action :set_breadcrumbs

  def new
    @telephone_appointment = TelephoneAppointment.new(step: 1)
    @feedback = FeedbackForm.for_online_booking
    retrieve_slots
  end

  def create
    @telephone_appointment = TelephoneAppointment.new(telephone_appointment_params)
    @feedback = FeedbackForm.for_online_booking
    retrieve_slots

    send(:"create_step_#{@telephone_appointment.step}")
  end

  private

  def create_step_1
    @telephone_appointment.step = 2
    render :new
  end

  def create_step_2
    if request.xhr?
      render partial: 'times', locals: { times: @times }
    else
      @telephone_appointment.step = 3
      render :new
    end
  end

  def create_step_3 # rubocop:disable Metrics/MethodLength
    if @telephone_appointment.ineligible?
      redirect_to ineligible_telephone_appointments_path
    elsif @telephone_appointment.valid? == false
      render :new
    elsif @telephone_appointment.save
      render :confirmation
    else
      @slot_assignment_failed = true
      @telephone_appointment.step = 1
      render :new
    end
  end

  def retrieve_slots
    slots ||= TelephoneAppointmentsApi.new.slots
    @months = retrieve_months(slots)
    @times = retrieve_times(slots)
  end

  def retrieve_months(slots)
    available_days = slots.keys.map do |date|
      DateTime.strptime(date, '%Y-%m-%d').to_date
    end

    available_days.each_with_object({}) do |day, months|
      key = day.change(day: 1)
      months[key] ||= []
      months[key] << day
      months
    end
  end

  def retrieve_times(slots)
    return unless @telephone_appointment.selected_date
    key = @telephone_appointment.selected_date.strftime('%Y-%m-%d')
    slots[key].map { |d| DateTime.parse(d).in_time_zone }
  end

  def telephone_appointment_params # rubocop:disable Metrics/MethodLength
    params
      .require(:telephone_appointment)
      .permit(
        :step,
        :selected_date,
        :start_at,
        :first_name,
        :last_name,
        :email,
        :phone,
        :memorable_word,
        :date_of_birth,
        :dc_pot_confirmed,
        :opt_out_of_market_research,
        :accept_terms_and_conditions,
        :date_of_birth_year,
        :date_of_birth_month,
        :date_of_birth_day
      )
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_an_appointment
    breadcrumb Breadcrumb.book_a_telephone_appointment
  end
end
