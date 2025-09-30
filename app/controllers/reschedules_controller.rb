# rubocop:disable Naming/VariableNumber
class ReschedulesController < ApplicationController
  include Embeddable

  PERMITTED_SCHEDULE_TYPE = 'pension_wise'.freeze

  before_action :load_reschedule
  before_action :retrieve_slots, only: :create

  def new
  end

  def create
    send("create_step_#{@reschedule.step}")
  end

  private

  def create_step_1
    if @reschedule.valid?
      redirect_to ineligible_reschedule_path unless @reschedule.appointment
    else
      render :new
    end
  end

  def create_step_2
    if request.xhr?
      render partial: 'times', locals: { times: @times }
    elsif slot_selected?
      @reschedule.advance!
    end
  end

  def create_step_3
    if @reschedule.reschedule
      redirect_to confirmation_telephone_appointments_path(
        extended_duration: @reschedule.extended_duration?,
        booking_reference: @reschedule.reference,
        booking_date: @reschedule.start_at,
        schedule_type: PERMITTED_SCHEDULE_TYPE
      )
    else
      redirect_to failure_reschedule_path
    end
  end

  def slot_selected?
    @reschedule.start_at
  end
  helper_method :slot_selected?

  def load_reschedule
    @reschedule = TelephoneReschedule.new(reschedule_params)
  end

  def retrieve_slots
    slots = TelephoneAppointmentsApi.new.slots(
      false,
      PERMITTED_SCHEDULE_TYPE,
      @reschedule.selected_date
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
    return unless @reschedule.selected_date

    key = @reschedule.selected_date.strftime('%Y-%m-%d')
    Array(slots[key]).map { |d| DateTime.parse(d).in_time_zone }
  end

  def reschedule_params # rubocop:disable Metrics/MethodLength
    params
      .fetch(:telephone_reschedule, {})
      .permit(
        :reference,
        :date_of_birth_year,
        :date_of_birth_month,
        :date_of_birth_day,
        :reason,
        :selected_date,
        :step,
        :start_at
      )
  end
end
# rubocop:enable Naming/VariableNumber
