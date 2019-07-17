class BookingRequestForm # rubocop:disable ClassLength
  include ActiveModel::Model

  attr_accessor :location_id, :first_name, :last_name, :email, :telephone_number,
                :memorable_word, :accessibility_requirements, :date_of_birth,
                :dc_pot, :additional_info, :remote_ip, :where_you_heard, :gdpr_consent

  attr_writer :selected_date, :start_at

  validate :validate_step_one

  with_options if: :step_two? do |step_two|
    step_two.validates :first_name, presence: true
    step_two.validates :last_name, presence: true
    step_two.validates :email, email: true
    step_two.validates :telephone_number, presence: true, format: /\A([\d+\-\s\+()]+)\z/
    step_two.validates :memorable_word, presence: true
    step_two.validates :accessibility_requirements, inclusion: { in: %w(0 1) }
    step_two.validates :dc_pot, inclusion: { in: %w(yes no not-sure) }
    step_two.validates :date_of_birth, presence: true
    step_two.validates :additional_info, length: { maximum: 160 }, allow_blank: true
    step_two.validates :where_you_heard, inclusion: { in: WhereYouHeard::OPTIONS.keys }
  end

  def initialize(location_id, opts)
    @location_id = location_id
    super(opts)
  end

  def selected_date
    Time.zone.parse(@selected_date) if @selected_date.present?
  end

  def start_at
    Time.zone.parse(@start_at) if @start_at.present?
  end

  def days?
    true
  end

  def times?
    true
  end

  def date_of_birth
    return nil unless /\d{4}-\d{1,2}-\d{1,2}/.match?(@date_of_birth)

    Date.parse(@date_of_birth)
  end

  def appointment_type
    if age < 50
      'under-50'
    elsif (50..54).cover?(age)
      '50-54'
    else
      '55-plus'
    end
  end

  def location
    @location ||= Locations.find(location_id)
  end

  def booking_location
    @booking_location ||= BookingLocations.find(location_id)
  end

  delegate :slots, :no_availability?, :limited_availability?, to: :location

  delegate :id, to: :booking_location, prefix: :booking_location

  def location_name
    booking_location.name_for(location_id)
  end

  def twilio_number
    booking_location
      .location_for(location_id)
      .online_booking_twilio_number
  end

  def step_one_valid?
    @step = 1
    valid?
  end

  def step_two_valid?
    @step = 2
    valid?
  end

  def step_two_invalid?
    !step_two_valid?
  end

  def eligible?
    return unless step_two_valid?

    age >= 50 && dc_pot != 'no'
  end

  def ineligible?
    !eligible?
  end

  def step_one?
    @step == 1
  end

  def step_two?
    @step == 2
  end

  def alternate_locations(limit: 5, radius: 5)
    Locations
      .nearest_to_postcode(location.postcode, radius: radius)
      .reject { |l| l.id == location_id || l.online_booking_disabled? || l.limited_availability? || l.no_availability? }
      .take(limit)
      .map { |l| LocationSearchResultDecorator.new(l) }
  end

  private

  def validate_step_one
    return unless step_one?

    errors.add(:start_at) if start_at.blank? || !selected_date
  end

  def age
    at = start_at.in_time_zone

    return 0 unless date_of_birth || at.nil?

    age = at.year - date_of_birth.year
    age -= 1 if at.to_date < date_of_birth + age.years
    age
  end
end
