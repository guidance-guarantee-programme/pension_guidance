class NudgeAppointmentsController < ApplicationController # rubocop:disable Metrics/ClassLength
  include Embeddable

  before_action :set_breadcrumbs
  before_action :nudge_appointment, only: %i[new create]

  helper_method :slot_selected?

  def new
    retrieve_slots
  end

  def create
    send("create_step_#{nudge_appointment.step}")
  end

  def confirmation
    return redirect_to root_path unless params[:booking_reference]

    @booking_reference = params[:booking_reference]
    @booking_date      = Time.zone.parse(params[:booking_date])
  end

  private

  def nudge_appointment
    @nudge_appointment ||= NudgeAppointment.new(nudge_appointment_params)
  end

  def create_step_1 # rubocop:disable Naming/VariableNumber
    retrieve_slots
    nudge_appointment.advance! { render :new }
  end

  def create_step_2 # rubocop:disable Naming/VariableNumber
    retrieve_slots
    if request.xhr?
      render partial: 'times', locals: { times: @times }
    elsif slot_selected?
      nudge_appointment.advance! { render :new }
    else
      render :new
    end
  end

  def create_step_3 # rubocop:disable Naming/VariableNumber
    if nudge_appointment.invalid?
      render :new
    elsif nudge_appointment.save
      confirm_to_customer(nudge_appointment)
    else
      retrieve_slots
      @slot_assignment_failed = true
      nudge_appointment.reset! { render :new }
    end
  end

  def confirm_to_customer(nudge_appointment)
    redirect_to confirmation_nudge_appointments_path(
      booking_reference: nudge_appointment.id,
      booking_date: nudge_appointment.start_at,
      schedule_type: nudge_appointment.schedule_type
    )
  end

  def retrieve_slots
    @lloyds_signposted = false

    slots = TelephoneAppointmentsApi.new.slots(
      @lloyds_signposted,
      nudge_appointment.schedule_type,
      nudge_appointment.selected_date
    )

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
    return unless nudge_appointment.selected_date

    key = nudge_appointment.selected_date.strftime('%Y-%m-%d')

    Array(slots[key]).map { |d| DateTime.parse(d).in_time_zone }
  end

  def nudge_appointment_params # rubocop:disable Metrics/MethodLength
    params
      .fetch(:nudge_appointment, {})
      .permit(
        :step,
        :selected_date,
        :start_at,
        :first_name,
        :last_name,
        :email,
        :phone,
        :mobile,
        :memorable_word,
        :date_of_birth,
        :where_you_heard,
        :date_of_birth_year,
        :date_of_birth_month,
        :date_of_birth_day,
        :accessibility_requirements,
        :notes,
        :confirmation,
        :eligibility_reason,
        :gdpr_consent,
        :adjustments
      )
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_an_appointment
    breadcrumb Breadcrumb.book_a_nudge_appointment
  end

  def slot_selected?
    nudge_appointment.start_at
  end
end
