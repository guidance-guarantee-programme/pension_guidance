class GuaranteedIncomeCalculator
  TAX_FREE_POT_PORTION = 0.25
  TAXABLE_POT_PORTION = 0.75

  def initialize(pot:, age:)
    self.pot = pot
    self.age = age
  end

  attr_accessor :pot, :age

  def estimate
    { income: income_rounded, tax_free_lump_sum: tax_free_lump_sum }
  end

  private

  def tax_free_lump_sum
    pot * TAX_FREE_POT_PORTION
  end

  def income
    taxable_amount * annuity_rate
  end

  def income_rounded
    income.round(-2)
  end

  def taxable_amount
    pot * TAXABLE_POT_PORTION
  end

  # https://pensionwise-guidance.atlassian.net/wiki/pages/viewpage.action?pageId=34237
  def annuity_rate
    case age
    when 55...60 then 0.04070
    when 60...65 then 0.04530
    when 65...70 then 0.05180
    when 70...75 then 0.05900
    else              0.07100
    end
  end
end
