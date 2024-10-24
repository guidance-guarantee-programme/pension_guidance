class TelephoneCancellation
  include ActiveModel::Model

  CANCELLATION_REASONS = {
    '32' => 'Inconvenient time',
    '33' => 'Wait time until appointment',
    '34' => 'Changed mind',
    '35' => 'Not prepared enough',
    '36' => 'Booked multiple appointments',
    '37' => 'Appointment no longer required',
    '38' => 'Received guidance from alternative source',
    '39' => 'Booked wrong type of appointment',
    '40' => 'Other'
  }.freeze

  attr_accessor :reference, :date_of_birth_year, :date_of_birth_month, :date_of_birth_day, :reason, :other_reason

  validates :reference, format: /\A\d+\z/
  validates :date_of_birth, presence: true
  validates :reason, inclusion: { in: CANCELLATION_REASONS.keys }
  validates :other_reason, presence: true, length: { maximum: 160 }, if: :reason_is_other?

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
      secondary_status: reason,
      other_reason: other_reason
    }
  end

  def reason_is_other?
    reason == CANCELLATION_REASONS.keys.last
  end
end
