class TelephoneReschedule
  include ActiveModel::Model

  RESCHEDULING_REASONS = {
    '1' => 'Inconvenient time',
    '2' => 'Wait time until appointment',
    '3' => 'Changed mind',
    '4' => 'Not prepared enough',
    '5' => 'Illness',
    '6' => 'Travelling'
  }.freeze

  attr_accessor :reference, :date_of_birth_year, :date_of_birth_month,
                :date_of_birth_day, :reason

  attr_writer :step, :selected_date, :start_at

  validates :reference, format: /\A\d+\z/
  validates :date_of_birth, presence: true
  validates :reason, inclusion: { in: RESCHEDULING_REASONS.keys }

  def reschedule
    return if invalid?

    TelephoneAppointmentsApi.new.reschedule(to_attributes)
  end

  def appointment
    @appointment ||= TelephoneAppointmentsApi.new.find(
      reference: reference,
      date_of_birth: date_of_birth
    )
  end

  def current_appointment_date
    Time.zone.parse(appointment['start']) if appointment['start']
  end

  def step
    Integer(@step || 1)
  end

  def advance!
    self.step = step + 1
  end

  def selected_date
    Time.zone.parse(@selected_date) if @selected_date.present?
  end

  def start_at
    Time.zone.parse(@start_at) if @start_at
  end

  def date_of_birth
    parts = [date_of_birth_year, date_of_birth_month, date_of_birth_day]

    return unless parts.all?(&:present?)

    parts.map!(&:to_i)

    Date.new(*parts)
  rescue Date::Error
    nil
  end

  def to_attributes
    {
      reference: reference,
      date_of_birth: date_of_birth.to_s,
      reason: reason,
      start_at: start_at
    }
  end
end
