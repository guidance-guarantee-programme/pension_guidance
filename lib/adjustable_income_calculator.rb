class AdjustableIncomeCalculator
  # 81 according to http://www.geoba.se/country.php?cc=GB&year=2015
  LIFE_EXPECTANCY = 86
  TAX_FREE_POT_PORTION = 0.25

  attr_accessor :pot, :age

  def initialize(pot, age)
    self.pot = pot
    self.age = age
  end

  def tax_free_lump_sum
    pot * TAX_FREE_POT_PORTION
  end

  def income
    round_to_two_decimal_places(taxable_portion / years_remaining)
  end

  def income_until(ending_age)
    years = ending_age - age
    round_to_two_decimal_places(taxable_portion / years)
  end

  def ending_age_for(desired_income)
    age + (taxable_portion / desired_income).floor
  end

  private

  def taxable_portion
    pot - tax_free_lump_sum
  end

  def years_remaining
    LIFE_EXPECTANCY - age
  end

  def round_to_two_decimal_places(amount)
    (amount * 100).round.to_f / 100
  end
end
