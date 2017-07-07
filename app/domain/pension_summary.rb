class PensionSummary
  include ActiveModel::Model

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

  attr_accessor *STEPS

  attr_accessor :current_step

  def initialize(*)
    super

    # Compulsory options are 'preselected'
    # options in the form. Forced selections.
    COMPULSORY_OPTIONS.each do |step|
      public_send("#{step}=", true)
    end

    # Any steps that aren't offered as options
    # are implicitly selected.
    (STEPS - OPTIONS).each do |step|
      public_send("#{step}=", true)
    end

    self.current_step ||= selected_steps.first
  end

  def attributes
    STEPS.each_with_object({}) { |o, memo| memo[o] = public_send(o) }
  end

  def selected_steps
    attributes.delete_if { |_, v| [1, '1', true, 'true'].exclude?(v) }.keys
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
