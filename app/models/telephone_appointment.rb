class TelephoneAppointment # rubocop:disable ClassLength
  include ActiveModel::Model

  attr_accessor(
    :id,
    :step,
    :selected_date,
    :start_at,
    :first_name,
    :last_name,
    :email,
    :phone,
    :memorable_word,
    :appointment_type,
    :date_of_birth,
    :dc_pot_confirmed,
    :where_you_heard,
    :date_of_birth_year,
    :date_of_birth_month,
    :date_of_birth_day,
    :gdpr_consent,
    :accessibility_requirements,
    :notes,
    :nudged,
    :smarter_signposted,
    :lloyds_signposted,
    :schedule_type,
    :referrer
  )

  validates :start_at, presence: true
  validates :first_name, presence: true, format: { without: /\d+/ }
  validates :last_name, presence: true, format: { without: /\d+/ }
  validates :email, email: true
  validate  :validate_phone
  validates :memorable_word, presence: true
  validates :date_of_birth, presence: true
  validates :dc_pot_confirmed, inclusion: { in: %w(yes no not-sure) }
  validates :where_you_heard, inclusion: { in: WhereYouHeard::OPTIONS.keys }
  validates :notes, length: { maximum: 160 }, allow_blank: true
  validates :notes, presence: true, if: :accessibility_requirements?
  validates :accessibility_requirements, inclusion: { in: %w(0 1) }
  validates :referrer, presence: true, if: :due_diligence?

  def due_diligence?
    schedule_type == 'due_diligence'
  end

  def accessibility_requirements?
    accessibility_requirements == '1'
  end

  def advance!
    self.step += 1
    yield
  end

  def reset!
    self.step = 1
    yield
  end

  def eligible?
    !ineligible?
  end

  def ineligible?
    ineligible_pension? || ineligible_age?
  end

  def ineligible_pension?
    dc_pot_confirmed == 'no'
  end

  def ineligible_age?
    return false if due_diligence?

    start_at.blank? || age(start_at) < 50
  end

  def attributes # rubocop:disable MethodLength, AbcSize
    {
      start_at: start_at,
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone: phone,
      memorable_word: memorable_word,
      date_of_birth: date_of_birth,
      dc_pot_confirmed: dc_pot_confirmed == 'yes',
      where_you_heard: where_you_heard,
      gdpr_consent: gdpr_consent,
      accessibility_requirements: accessibility_requirements,
      notes: notes,
      nudged: nudged,
      smarter_signposted: smarter_signposted,
      lloyds_signposted: lloyds_signposted,
      schedule_type: schedule_type,
      referrer: referrer
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

    TelephoneAppointmentsApi.new.create(self)
  end

  private

  def validate_phone
    unless phone.present? && /\A([\d+\-\s\+()]+)\z/ === phone # rubocop:disable GuardClause, CaseEquality
      errors.add(:phone, :invalid)
    end
  end

  def age(at)
    return 0 unless date_of_birth

    age = at.year - date_of_birth.year
    age -= 1 if at.to_date < date_of_birth + age.years
    age
  end
end
