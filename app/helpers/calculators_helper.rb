module CalculatorsHelper
  CONTRIBUTION_MULTIPLIER = 5
  DEFAULT_CONTRIBUTION_UPPER_LIMIT = 500

  def leave_pot_untouched_slider_max(contribution)
    max = contribution * CONTRIBUTION_MULTIPLIER
    max = DEFAULT_CONTRIBUTION_UPPER_LIMIT if max.zero?
    max
  end
end
