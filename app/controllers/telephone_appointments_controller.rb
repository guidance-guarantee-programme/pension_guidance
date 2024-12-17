class TelephoneAppointmentsController < ApplicationController # rubocop:disable Metrics/ClassLength
  include Embeddable

  before_action :assign_rebook_after_cancellation, only: :new
  before_action :set_breadcrumbs
  before_action :telephone_appointment, only: %i[new create]

  helper_method :slot_selected?

  def new
    retrieve_slots
    check_lloyds_cookie!
  end

  def create
    send("create_step_#{telephone_appointment.step}")
  end

  def confirmation
    return redirect_to root_path unless params[:booking_reference]

    @booking_reference = params[:booking_reference]
    @booking_date      = Time.zone.parse(params[:booking_date])
    @due_diligence     = schedule_type == 'due_diligence'
  end

  def ineligible
    @ineligible_age     = params[:ineligible_age]
    @ineligible_pension = params[:ineligible_pension]
  end

  def nudge
  end

  private

  def telephone_appointment
    @telephone_appointment ||= TelephoneAppointment.new(telephone_appointment_params)
  end

  def create_step_1
    retrieve_slots
    telephone_appointment.advance! { render :new }
  end

  def create_step_2
    retrieve_slots
    if request.xhr?
      render partial: 'times', locals: { times: @times }
    elsif slot_selected?
      telephone_appointment.advance! { render :new }
    else
      render :new
    end
  end

  def create_step_3 # rubocop:disable Metrics/MethodLength
    if telephone_appointment.invalid?
      render :new
    elsif telephone_appointment.ineligible?
      ineligible_for_customer(telephone_appointment)
    elsif telephone_appointment.save
      confirm_to_customer(telephone_appointment)
    else
      retrieve_slots
      @slot_assignment_failed = true
      telephone_appointment.reset! { render :new }
    end
  end

  def ineligible_for_customer(telephone_appointment)
    redirect_to ineligible_telephone_appointments_path(
      ineligible_age: telephone_appointment.ineligible_age?,
      ineligible_pension: telephone_appointment.ineligible_pension?
    )
  end

  def confirm_to_customer(telephone_appointment)
    redirect_to confirmation_telephone_appointments_path(
      booking_reference: telephone_appointment.id,
      booking_date: telephone_appointment.start_at,
      schedule_type: telephone_appointment.schedule_type
    )
  end

  def retrieve_slots
    slots = TelephoneAppointmentsApi.new.slots(
      lloyds_signposted?,
      telephone_appointment.schedule_type,
      telephone_appointment.selected_date
    )

    @months = retrieve_months(slots)
    @times  = retrieve_times(slots)
  end

  def assign_rebook_after_cancellation
    cookies[:rebooked_from_id] = verifier.verify(params[:rebooked_from]) if params[:rebooked_from]
  end

  def retrieve_months(slots)
    default_months = Hash.new { |h, k| h[k] = [] }
    available_days = slots.keys.map(&:to_date)

    available_days.each_with_object(default_months) do |day, months|
      months[day.beginning_of_month] << day
    end
  end

  def retrieve_times(slots)
    return unless telephone_appointment.selected_date

    key = telephone_appointment.selected_date.strftime('%Y-%m-%d')

    Array(slots[key]).map { |d| DateTime.parse(d).in_time_zone }
  end

  def telephone_appointment_params # rubocop:disable Metrics/MethodLength
    params
      .fetch(:telephone_appointment, {})
      .permit(
        :step,
        :selected_date,
        :start_at,
        :first_name,
        :last_name,
        :email,
        :country_of_residence,
        :phone,
        :memorable_word,
        :date_of_birth,
        :dc_pot_confirmed,
        :where_you_heard,
        :date_of_birth_year,
        :date_of_birth_month,
        :date_of_birth_day,
        :gdpr_consent,
        :accessibility_requirements,
        :notes,
        :gdpr_consent,
        :schedule_type,
        :referrer,
        :nudged,
        :embedded,
        :rebooked_from_id
      ).merge(
        smarter_signposted: smarter_signposted?,
        lloyds_signposted: lloyds_signposted?,
        schedule_type: schedule_type,
        rebooked_from_id: rebooked_from_id
      ).reverse_merge(
        nudged: params[:nudged],
        embedded: params[:embedded]
      )
  end

  def set_breadcrumbs
    breadcrumb Breadcrumb.book_an_appointment
    breadcrumb Breadcrumb.book_a_telephone_appointment
  end

  def slot_selected?
    telephone_appointment.start_at
  end

  def schedule_type
    params.dig(:telephone_appointment, :schedule_type) || params.fetch(:schedule_type) { 'pension_wise' }
  end

  def check_lloyds_cookie!
    cookies.permanent[:lloyds_signposted] = 'true' if params[:lloyds] || params[:lbgptl]
  end

  def rebooked_from_id
    cookies[:rebooked_from_id]
  end

  def smarter_signposted?
    cookies.permanent[:smarter_signposted] == 'true'
  end
  helper_method :smarter_signposted?

  def lloyds_signposted?
    cookies.permanent[:lloyds_signposted] == 'true'
  end
  helper_method :lloyds_signposted?

  def canonical_url
    if lloyds_signposted?
      'https://www.moneyhelper.org.uk/lbgptl'
    elsif @telephone_appointment.due_diligence?
      'https://www.moneyhelper.org.uk/pension-safeguarding'
    else
      'https://www.moneyhelper.org.uk/en/pensions-and-retirement/pension-wise/book-a-free-pension-wise-appointment/how-to-book-a-phone-appointment'
    end
  end
  helper_method :canonical_url
end
