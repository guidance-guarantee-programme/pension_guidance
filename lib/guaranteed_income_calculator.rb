class GuaranteedIncomeCalculator
  TAX_FREE_POT_PORTION = 0.25
  TAXABLE_POT_PORTION = 0.75

  attr_accessor :pot, :age

  def initialize(pot, age)
    self.pot = pot
    self.age = age
  end

  def tax_free_lump_sum
    pot * TAX_FREE_POT_PORTION
  end

  def single_annuity
    taxable_amount * single_annuity_rate
  end

  private

  def taxable_amount
    pot * TAXABLE_POT_PORTION
  end

  # http://www.sharingpensions.co.uk/annuity_rates.htm#text5
  def single_annuity_rate
    case age
    when 55...60 then 0.04614
    when 60...65 then 0.05160
    when 65...70 then 0.05828
    when 70...75 then 0.06670
    else              0.07875
    end
  end
end
