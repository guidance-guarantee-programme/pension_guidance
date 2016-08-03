class IncomeTaxCalculator
  STANDARD_PERSONAL_ALLOWANCE = 11_000
  PERSONAL_ALLOWANCE_REDUCTION_THRESHOLD = 100_000
  PERSONAL_ALLOWANCE_REDUCTION_RATIO = 2

  BASIC_RATE_UPPER_LIMIT = 32_000
  BASIC_RATE_TAX = 0.2

  HIGHER_RATE_UPPER_LIMIT = 150_000
  HIGHER_RATE_TAX = 0.4

  ADDITIONAL_RATE_TAX = 0.45

  TAXABLE_LUMP_SUM_PORTION = 0.75

  attr_accessor :lump_sum_received, :lump_sum_tax

  def self.personal_allowance_for(income:)
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

  # rubocop:disable AbcSize, MethodLength
  def self.marginal_tax_for_lump_sum_with_income(lump_sum:, income:)
    potentially_taxable_lump_sum = lump_sum * self::TAXABLE_LUMP_SUM_PORTION
    allowance = personal_allowance_for(income: potentially_taxable_lump_sum + income)

    # adjust bands according to income
    income_above_allowance = [income - allowance, 0].max
    effective_allowance = [allowance - income, 0].max
    effective_basic_rate_upper_limit = [BASIC_RATE_UPPER_LIMIT - income_above_allowance, 0].max
    effective_higher_rate_upper_limit = [HIGHER_RATE_UPPER_LIMIT - income_above_allowance, 0].max

    # personal allowance
    remaining_taxable_lump_sum = if potentially_taxable_lump_sum <= effective_allowance
                                   0
                                 else
                                   [potentially_taxable_lump_sum - effective_allowance, 0].max
                                 end

    # basic rate
    subject_to_basic_rate = [remaining_taxable_lump_sum, effective_basic_rate_upper_limit].min
    remaining_taxable_lump_sum -= subject_to_basic_rate

    # higher rate
    subject_to_higher_rate = [
      remaining_taxable_lump_sum,
      (effective_higher_rate_upper_limit - effective_basic_rate_upper_limit)
    ].min
    remaining_taxable_lump_sum -= subject_to_higher_rate

    # additional rate
    subject_to_additional_rate = remaining_taxable_lump_sum

    {
      basic: subject_to_basic_rate * BASIC_RATE_TAX,
      higher: subject_to_higher_rate * HIGHER_RATE_TAX,
      additional: subject_to_additional_rate * ADDITIONAL_RATE_TAX
    }
  end
  # rubocop:enable AbcSize, MethodLength

  def initialize(lump_sum:, income:)
    tax = self.class.marginal_tax_for_lump_sum_with_income(lump_sum: lump_sum, income: income)

    self.lump_sum_tax = tax.values.reduce(:+)
    self.lump_sum_received = lump_sum - lump_sum_tax
  end
end
