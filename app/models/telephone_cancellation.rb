class TelephoneCancellation
  include ActiveModel::Model

  CANCELLATION_REASONS = {
    '32' => 'Inconvenient time',
    '33' => 'Changed mind',
    '34' => 'Not prepared enough',
    '35' => 'Booked multiple appointments',
    '36' => 'Appointment no longer required',
    '37' => 'Booked wrong type of appointment',
    '38' => 'Other'
  }.freeze

  attr_accessor :reference, :date_of_birth_year, :date_of_birth_month, :date_of_birth_day, :reason

  validates :reference, format: /\A\d+\z/
  validates :date_of_birth, presence: true
  validates :reason, inclusion: { in: CANCELLATION_REASONS.keys }

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
      secondary_status: reason
    }
  end
end
