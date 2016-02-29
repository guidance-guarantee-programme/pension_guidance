class GuaranteedIncomeCalculator
  TAX_FREE_POT_PORTION = 0.25
  TAXABLE_POT_PORTION = 0.75

  def initialize(pot:, age:)
    self.pot = pot
    self.age = age
  end

  attr_accessor :pot, :age

  def estimate
    { income: taxable_amount * annuity_rate, tax_free_lump_sum: tax_free_lump_sum }
  end

  private

  def tax_free_lump_sum
    pot * TAX_FREE_POT_PORTION
  end

  def income
    taxable_amount * annuity_rate
  end

  def taxable_amount
    pot * TAXABLE_POT_PORTION
  end

  # https://pensions-guidance.atlassian.net/wiki/display/WIKI/averaged+annuity+rate
  def annuity_rate
    case age
    when 55...60 then 0.04490
    when 60...65 then 0.04768
    when 65...70 then 0.05519
    when 70...75 then 0.06344
    else              0.07559
    end
  end
end
