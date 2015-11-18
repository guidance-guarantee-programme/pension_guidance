class GuaranteedIncomeCalculator
  TAX_FREE_POT_PORTION = 0.25

  attr_accessor :pot

  def initialize(pot)
    self.pot = pot
  end

  def tax_free_lump_sum
    pot * TAX_FREE_POT_PORTION
  end
end
