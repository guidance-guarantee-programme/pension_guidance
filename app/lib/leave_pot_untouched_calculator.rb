class LeavePotUntouchedCalculator
  INTEREST_RATE = 0.03
  YEARS = (1..5).freeze

  def initialize(pot:, contribution:)
    self.pot = pot
    self.contribution = contribution
  end

  attr_accessor :pot, :contribution

  def estimate
    YEARS.map { |year| Financial.future_value(pot, annual_contribution, INTEREST_RATE, year) }
  end

  private

  def annual_contribution
    contribution * 12
  end
end
