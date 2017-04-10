class BookingRequestForm
  include ActiveModel::Model

  attr_accessor :location_id, :primary_slot, :secondary_slot, :tertiary_slot,
                :first_name, :last_name, :email, :telephone_number,
                :memorable_word, :accessibility_requirements,
                :date_of_birth, :opt_in, :dc_pot

  with_options if: :step_one? do |step_one|
    step_one.validates :primary_slot, presence: true
    step_one.validates :secondary_slot, presence: true
    step_one.validates :tertiary_slot, presence: true
  end

  with_options if: :step_two? do |step_two|
    step_two.validates :first_name, presence: true
    step_two.validates :last_name, presence: true
    step_two.validates :email, email: true
    step_two.validates :telephone_number, presence: true
    step_two.validates :memorable_word, presence: true
    step_two.validates :accessibility_requirements, inclusion: { in: %w(0 1) }
    step_two.validates :opt_in, acceptance: { accept: '1' }
    step_two.validates :dc_pot, inclusion: { in: %w(yes no not-sure) }
    step_two.validates :date_of_birth, presence: true
  end

  def initialize(location_id, opts)
    @location_id = location_id
    super(opts)
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

  def slots_for_calendar
    @slots_for_calendar ||= booking_location.location_for(location_id).slots.map(&:to_calendar)
  end

  def booking_location
    @booking_location ||= BookingLocations.find(location_id)
  end

  delegate :id, to: :booking_location, prefix: :booking_location

  def location_name
    booking_location.name_for(location_id)
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

  private

  def age
    return 0 unless date_of_birth

    age = Time.zone.today.year - date_of_birth.year
    age -= 1 if Time.zone.today.to_date < date_of_birth + age.years
    age
  end
end
