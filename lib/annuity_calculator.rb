class AnnuityCalculator < IncomeTaxCalculator
  STEP_SIZE = 500
  TAXABLE_LUMP_SUM_PORTION = 1.0

  PERSONAL_ALLOWANCE_UPPER_LIMIT = PERSONAL_ALLOWANCE_REDUCTION_THRESHOLD +
                                   STANDARD_PERSONAL_ALLOWANCE * PERSONAL_ALLOWANCE_REDUCTION_RATIO

  attr_reader :pension_income, :income

  def initialize(age:, life_expectancy:, pension_income:, income:)
    @pension_income = pension_income * [life_expectancy - age, 0].max
    @income = income
  end

  attr_accessor :age, :life_expectancy, :pension_income

  def estimate # rubocop:disable AbcSize, MethodLength
    if (lower_bound + income) < PERSONAL_ALLOWANCE_REDUCTION_THRESHOLD
      {
        valuation: round(lower_bound),
        tax: tax_for(round(lower_bound))
      }
    elsif (upper_bound + income) > PERSONAL_ALLOWANCE_UPPER_LIMIT
      {
        valuation: round(upper_bound),
        tax: tax_for(round(upper_bound))
      }
    else
      estimated_payout = round(lower_bound)
      current_estimated_payout = estimated_payout
      current_diff = (estimated_payout - tax_for(estimated_payout) - pension_income).abs

      while estimated_payout < upper_bound
        estimated_payout += ((value.to_i - 1) / STEP_SIZE + 1) * STEP_SIZE
        diff = (estimated_payout - tax_for(estimated_payout) - pension_income).abs
        if diff < current_diff
          current_estimated_payout = estimated_payout
          current_diff = diff
        end
      end

      {
        valuation: current_estimated_payout,
        tax: tax_for(current_estimated_payout)
      }
    end
  end

  def tax_for(value)
    self.class.marginal_tax_for_lump_sum_with_income(income: income, lump_sum: value).sum { |_, tax| tax }
  end

  def round(value)
    ((value.to_i + (STEP_SIZE / 2)) / STEP_SIZE) * STEP_SIZE
  end

  def lower_bound
    @lower_bound ||= self.class.value(
      income: income,
      pension_income: pension_income,
      allowance: STANDARD_PERSONAL_ALLOWANCE
    )
  end

  def upper_bound
    @upper_bound ||= self.class.value(income: income, pension_income: pension_income, allowance: 0)
  end

  def self.value(income:, pension_income:, allowance:) # rubocop:disable AbcSize, MethodLength
    # adjust bands according to income
    income_above_allowance = [income - allowance, 0].max
    effective_allowance = [allowance - income, 0].max
    effective_basic_rate_upper_limit = [BASIC_RATE_UPPER_LIMIT - income_above_allowance, 0].max
    effective_higher_rate_upper_limit = [HIGHER_RATE_UPPER_LIMIT - income_above_allowance, 0].max

    # personal allowance
    remaining_pension_income = [pension_income - effective_allowance, 0].max

    # basic rate
    subject_to_basic_rate = [remaining_pension_income, effective_basic_rate_upper_limit * (1.0 - BASIC_RATE_TAX)].min
    remaining_pension_income -= subject_to_basic_rate

    # higher rate
    subject_to_higher_rate = [
      remaining_pension_income,
      (effective_higher_rate_upper_limit - effective_basic_rate_upper_limit) * HIGHER_RATE_TAX
    ].min
    remaining_pension_income -= subject_to_higher_rate

    # additional rate
    subject_to_additional_rate = remaining_pension_income

    [pension_income, effective_allowance].min +
      subject_to_basic_rate / (1.0 - BASIC_RATE_TAX) +
      subject_to_higher_rate / (1.0 - HIGHER_RATE_TAX) +
      subject_to_additional_rate / (1.0 - ADDITIONAL_RATE_TAX)
  end
end
