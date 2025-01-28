class NudgeAppointment # rubocop:disable Metrics/ClassLength
  include ActiveModel::Model

  PHONE_REGEX = /\A([\d+\-\s+()]+)\z/.freeze

  ELIGIBILITY_OPTIONS = {
    'protected_pension_age' => 'Protected pension age',
    'ill_health' => 'Ill health',
    'inherited_pension_pot' => 'Inherited pension pot'
  }.freeze

  attr_accessor(
    :id,
    :first_name,
    :last_name,
    :email,
    :phone,
    :mobile,
    :memorable_word,
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

  attr_writer :date_of_birth, :selected_date, :start_at, :step

  validates :start_at, presence: true
  validates :first_name, presence: true, format: { without: /\d+/ }
  validates :last_name, presence: true, format: { without: /\d+/ }
  validate  :validate_phone
  validates :confirmation, inclusion: { in: %w[email sms] }
  validates :email, email: true, if: :confirm_email?
  validate :validate_mobile
  validates :memorable_word, presence: true
  validates :date_of_birth, presence: true
  validates :eligibility_reason, inclusion: { in: ELIGIBILITY_OPTIONS.keys }, unless: :eligible_age?
  validates :accessibility_requirements, presence: true
  validates :adjustments, length: { maximum: 160 }, allow_blank: true
  validates :adjustments, presence: true, if: :accessibility_requirements?
  validates :notes, length: { maximum: 160 }, allow_blank: true
  validates :gdpr_consent, inclusion: { in: %w[yes no] }

  def accessibility_requirements?
    ActiveRecord::Type::Boolean.new.cast(accessibility_requirements) || false
  end

  def advance!
    self.step += 1
    yield
  end

  def reset!
    self.step = 1
    yield
  end

  def attributes # rubocop:disable Metrics/MethodLength
    {
      start_at: start_at,
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone: phone,
      memorable_word: memorable_word,
      date_of_birth: date_of_birth,
      accessibility_requirements: accessibility_requirements,
      notes: notes,
      nudge_confirmation: confirmation,
      mobile: mobile,
      nudge_eligibility_reason: eligibility_reason,
      gdpr_consent: gdpr_consent,
      adjustments: adjustments.to_s
    }
  end

  def date_of_birth
    parts = [
      date_of_birth_year,
      date_of_birth_month,
      date_of_birth_day
    ]

    return unless parts.all?(&:present?)

    parts.map!(&:to_i)

    Date.new(*parts)
  end

  def selected_date
    Time.zone.parse(@selected_date) if @selected_date.present?
  end

  def start_at
    Time.zone.parse(@start_at) if @start_at.present?
  end

  def step
    Integer(@step || 1)
  end

  def save
    return unless valid?

    TelephoneAppointmentsApi.new.create_nudge(self)
  end

  def schedule_type
    'pension_wise'.freeze
  end

  private

  def eligible_age?
    start_at.present? && age(start_at) >= 50
  end

  def confirm_email?
    confirmation == 'email'
  end

  def confirm_sms?
    confirmation == 'sms'
  end

  def validate_phone
    errors.add(:phone, :invalid) unless phone.present? && PHONE_REGEX === phone
  end

  def validate_mobile
    return unless confirm_sms?

    errors.add(:mobile, :invalid) unless mobile.present? && PHONE_REGEX === mobile
  end

  def age(at)
    return 0 unless date_of_birth

    age = at.year - date_of_birth.year
    age -= 1 if at.to_date < date_of_birth + age.years
    age
  end
end
