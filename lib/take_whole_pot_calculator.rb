class TakeWholePotCalculator
  STANDARD_PERSONAL_ALLOWANCE = 10_600
  PERSONAL_ALLOWANCE_REDUCTION_THRESHOLD = 100_000
  PERSONAL_ALLOWANCE_REDUCTION_RATIO = 2

  def self.personal_allowance_for(income)
    if income <= PERSONAL_ALLOWANCE_REDUCTION_THRESHOLD
      STANDARD_PERSONAL_ALLOWANCE
    else
      amount_over_threshold = income - PERSONAL_ALLOWANCE_REDUCTION_THRESHOLD
      reduction = [
        amount_over_threshold / PERSONAL_ALLOWANCE_REDUCTION_RATIO,
        STANDARD_PERSONAL_ALLOWANCE
      ].min
      STANDARD_PERSONAL_ALLOWANCE - reduction
    end
  end
end
