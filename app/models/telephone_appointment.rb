class TelephoneAppointment # rubocop:disable Metrics/ClassLength
  include ActiveModel::Model

  NUDGE_EMBED_WHERE_YOU_HEARD_ID = '25'.freeze
  DEFAULT_COUNTRY_OF_RESIDENCE   = 'GB'.freeze

  attr_accessor(
    :id,
    :first_name,
    :last_name,
    :email,
    :phone,
    :memorable_word,
    :appointment_type,
    :dc_pot_confirmed,
    :date_of_birth_year,
    :date_of_birth_month,
    :date_of_birth_day,
    :gdpr_consent,
    :accessibility_requirements,
    :notes,
    :nudged,
    :embedded,
    :smarter_signposted,
    :lloyds_signposted,
    :schedule_type,
    :referrer,
    :rebooked_from_id,
    :attended_digital,
    :adjustments
  )

  attr_writer(
    :country_of_residence,
    :date_of_birth,
    :where_you_heard,
    :start_at,
    :selected_date,
    :step
  )

  validates :start_at, presence: true
  validates :first_name, presence: true, format: { without: /\d+/ }
  validates :last_name, presence: true, format: { without: /\d+/ }
  validates :email, email: true
  validate  :validate_phone
  validate  :validate_memorable_word
  validates :memorable_word, presence: true
  validates :date_of_birth, presence: true
  validates :dc_pot_confirmed, inclusion: { in: %w[yes no not-sure] }
  validates :where_you_heard, inclusion: { in: WhereYouHeard::OPTIONS.keys }, unless: :embedded?
  validates :notes, length: { maximum: 160 }, allow_blank: true
  validates :accessibility_requirements, presence: true
  validates :adjustments, length: { maximum: 160 }, allow_blank: true
  validates :adjustments, presence: true, if: :accessibility_requirements?
  validates :referrer, presence: true, if: :due_diligence?
  validates :country_of_residence, presence: true, if: :due_diligence?
  validates :gdpr_consent, inclusion: { in: %w[yes no] }

  def due_diligence?
    schedule_type == 'due_diligence'
  end

  def embedded?
    embedded == 'true'
  end

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

  def attributes # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    {
      start_at: start_at,
      first_name: first_name,
      last_name: last_name,
      email: email,
      country_code: country_of_residence,
      phone: phone,
      memorable_word: memorable_word,
      date_of_birth: date_of_birth,
      dc_pot_confirmed: dc_pot_confirmed == 'yes',
      where_you_heard: where_you_heard,
      gdpr_consent: gdpr_consent,
      accessibility_requirements: accessibility_requirements,
      adjustments: adjustments,
      notes: notes,
      nudged: nudged,
      smarter_signposted: smarter_signposted,
      lloyds_signposted: lloyds_signposted,
      schedule_type: schedule_type,
      referrer: referrer,
      rebooked_from_id: rebooked_from_id,
      attended_digital: attended_digital
    }
  end

  def country_of_residence
    @country_of_residence || DEFAULT_COUNTRY_OF_RESIDENCE
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

  def where_you_heard
    return NUDGE_EMBED_WHERE_YOU_HEARD_ID if embedded?

    @where_you_heard
  end

  def save
    return unless valid?

    TelephoneAppointmentsApi.new.create(self)
  end

  private

  def validate_memorable_word
    return if memorable_word.blank?

    errors.add(:memorable_word, :invalid) if ProfanityFilter::Base.profane?(memorable_word)
  end

  def validate_phone
    unless phone.present? && /\A([\d+\-\s+()]+)\z/ === phone && phone_length_valid? # rubocop:disable Style/GuardClause, Style/CaseEquality
      errors.add(:phone, :invalid)
    end
  end

  def phone_length_valid?
    phone.gsub(/[^\d]/, '').length > 6
  end

  def age(at)
    return 0 unless date_of_birth

    age = at.year - date_of_birth.year
    age -= 1 if at.to_date < date_of_birth + age.years
    age
  end
end
