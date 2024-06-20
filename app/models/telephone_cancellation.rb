class TelephoneCancellation
  include ActiveModel::Model

  attr_accessor :reference, :date_of_birth_year, :date_of_birth_month, :date_of_birth_day

  validates :reference, format: /\A\d+\z/
  validates :date_of_birth, presence: true

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
      date_of_birth: date_of_birth.to_s
    }
  end
end
