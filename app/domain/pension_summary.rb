class PensionSummary < ApplicationRecord

  # 'Steps' are all the topics involved in the summary,
  # (including one that isn't offered as an option, 'final')
  # Also this array specifies the order they're presented,
  # after selection, which is different to the sequence in
  # which they're offered up as options.
  STEPS = %w(
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
  ).freeze

  PRIMARY_OPTIONS = %w(
    leave_your_pot_untouched
    get_a_guaranteed_income
    get_an_adjustable_income
    take_cash
    take_whole
    mix_your_options
  ).freeze

  SECONDARY_OPTIONS = %w(
    how_my_pension_affects_my_benefits
    getting_help_with_debt
    taking_my_pension_if_im_ill
    transferring_my_pension_to_another_provider
  ).freeze

  COMPULSORY_OPTIONS = %w(
    scams
    how_my_pension_is_taxed
  ).freeze

  OPTIONS = [*PRIMARY_OPTIONS, *SECONDARY_OPTIONS, *COMPULSORY_OPTIONS].freeze

  def generate(now = Time.current)
    update(generated_at: now)
  end

  def generated?
    generated_at?
  end

  def steps
    attributes.slice(*STEPS)
  end

  def selected_steps
    steps.each_with_object([]) { |(k, v), m| m << k if v }
  end

  def current_step
    @current_step ||= selected_steps.first
  end

  def current_step=(step)
    @current_step = \
      if selected_steps.include?(step)
        step
      else
        selected_steps.first
      end
  end

  def current_step_number
    selected_steps.index(current_step) + 1
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
end
