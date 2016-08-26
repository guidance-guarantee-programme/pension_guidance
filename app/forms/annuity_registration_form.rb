class AnnuityRegistrationForm
  FIELDS = [
    :first_name, :last_name, :phone_number, :email,
    :postcode, :age, :annuity_value, :appointment_type,
    :annuity_type, :desired_outcome_from_appointment
  ].freeze

  include ActiveModel::Model

  attr_accessor *FIELDS

  validates :first_name, :last_name, :phone_number, :postcode,
            presence: true
  validates :email, format: /.+@.+\..+/
  validates :annuity_type,
            inclusion: { in: %w(in_own_name in_group_name) }
  validates :age, :annuity_value,
            numericality: { greater_than: 0, allow_blank: false }
  validates :appointment_type, inclusion: { in: %w(face_to_face phone) }

  def message_content # rubocop:disable Metrics/MethodLength
    {
      name: name,
      email: email,
      message: message,
      subject: 'Annuities Registration',
      tags: %w(annuities_registration),
      custom_fields: {
        id: csv_field_id,
        value: csv_data
      }
    }
  end

  private

  def name
    "#{first_name} #{last_name}".chomp
  end

  def csv_field_id
    ENV['ZEN_DESK_ANNUITIES_REGISTRATION_CSV_FIELD_ID']
  end

  def csv_data
    FIELDS.map { |field_name| clean_for_csv_output(public_send(field_name)) }.join(',')
  end

  def message
    FIELDS.map { |field_name| "#{field_name.to_s.humanize}: #{public_send(field_name)}" }.join("\n")
  end

  def clean_for_csv_output(value)
    value.to_s.tr(',', ';').gsub(/[\r\n]+/, ' ')
  end
end
