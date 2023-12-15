# rubocop:disable Metrics/ClassLength
class PensionSummary < ApplicationRecord
  class StepViewing < ApplicationRecord
    belongs_to :pension_summary

    class << self
      def default_scope
        order(:created_at)
      end
    end
  end

  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/

  # 'Steps' are all the topics involved in the summary,
  # (including one that isn't offered as an option, 'final')
  # Also this array specifies the order they're presented,
  # after selection, which is different to the sequence in
  # which they're offered up as options.
  STEPS = %w[
    leave_your_pot_untouched
    get_a_guaranteed_income
    get_an_adjustable_income
    take_cash
    take_whole
    mix_your_options
    how_my_pension_is_taxed
    scams
    how_my_pension_affects_my_benefits
    getting_help_with_debt
    taking_my_pension_if_im_ill
    transferring_my_pension_to_another_provider
    final
  ].freeze

  PILOT_STEPS = %w[
    your_experience
    thank_you
  ].freeze

  PRIMARY_OPTIONS = %w[
    leave_your_pot_untouched
    get_a_guaranteed_income
    get_an_adjustable_income
    take_cash
    take_whole
    mix_your_options
  ].freeze

  SECONDARY_OPTIONS = %w[
    how_my_pension_affects_my_benefits
    getting_help_with_debt
    taking_my_pension_if_im_ill
    transferring_my_pension_to_another_provider
  ].freeze

  COMPULSORY_OPTIONS = %w[
    scams
    how_my_pension_is_taxed
  ].freeze

  OPTIONS = [*PRIMARY_OPTIONS, *SECONDARY_OPTIONS, *COMPULSORY_OPTIONS].freeze

  ABOUT_YOUR_GENDER = %w[
    male
    female
    unspecified
    other
  ].freeze

  ABOUT_YOUR_AGE = [
    'Under 50',
    '50-54',
    '55-59',
    '60-64',
    '65-69',
    '70 or over'
  ].freeze

  COUNTRIES = %w[
    england
    scotland
    wales
    northern_ireland
    channel_islands_or_isle_of_man
    other
  ].freeze

  has_many :step_viewings

  validates :gender, inclusion: { in: ABOUT_YOUR_GENDER, allow_blank: true }
  validates :age, inclusion: { in: ABOUT_YOUR_AGE, allow_blank: true }

  validate if: :consent_given? do
    errors.add(:name, :blank) unless name?
    errors.add(:email, :blank) unless email?
    errors.add(:email, :invalid) unless email_valid?
  end

  validate if: :name? do
    errors.add(:consent_given, :accepted) unless consent_given?
    errors.add(:email, :blank) unless email?
    errors.add(:email, :invalid) unless email_valid?
  end

  validate if: :email? do
    errors.add(:consent_given, :accepted) unless consent_given?
    errors.add(:name, :blank) unless name?
    errors.add(:email, :invalid) unless email_valid?
  end

  def generate(attrs, now: Time.current)
    update(attrs.merge(generated_at: now))
  end

  def generated?
    generated_at?
  end

  def submit(attrs, now: Time.current)
    update(attrs.merge(submitted_at: now))
  end

  def submitted?
    submitted_at?
  end

  def steps
    attributes.slice(*STEPS)
  end

  def pilot_steps
    if pilot?
      Hash[PILOT_STEPS.zip([true] * PILOT_STEPS.size)]
    else
      {}
    end
  end

  def all_steps
    attributes.merge(pilot_steps).slice(*STEPS, *PILOT_STEPS)
  end

  def selected_steps
    steps.each_with_object([]) { |(k, v), m| m << k if v }
  end

  def all_selected_steps
    all_steps.each_with_object([]) { |(k, v), m| m << k if v }
  end

  def current_step
    @current_step ||= selected_steps.first
  end

  def current_step=(step)
    @current_step = \
      if all_selected_steps.include?(step)
        step
      else
        all_selected_steps.first
      end

    step_viewings.create!(step: @current_step)
  end

  def current_step_number
    all_selected_steps.index(current_step) + 1
  end

  def first_step?
    current_step == selected_steps.first
  end

  def last_step?
    current_step == selected_steps.last
  end

  def next_step
    selected_steps[current_step_number]
  end

  def email_valid?
    email.to_s =~ EMAIL_REGEX
  end
end
# rubocop:enable Metrics/ClassLength
