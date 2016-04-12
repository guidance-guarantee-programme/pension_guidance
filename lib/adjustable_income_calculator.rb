class AdjustableIncomeCalculator
  LIFE_EXPECTANCY = 85
  TAX_FREE_POT_PORTION = 0.25
  GROWTH_INTEREST_RATE = 0.03
  AMOUNT_TO_REDUCE_LIFETIME_PAYMENT_BY = 100

  def initialize(pot:, age:, desired_income:)
    self.pot = pot
    self.age = age
    self.desired_income = desired_income
  end

  attr_accessor :pot, :age, :desired_income

  def estimate
    {
      tax_free_lump_sum: tax_free_lump_sum,
      taxable_portion: taxable_portion,
      growth_interest_rate: GROWTH_INTEREST_RATE * 100,
      monthly_drawdown_amount: (normalised_drawdown_amount / 12).to_i,
      desired_income_with_pot_growth_lasts_until: desired_income_with_pot_growth_lasts_until.to_i,
      monthly_income_until_life_expectancy: monthly_income_until_life_expectancy.to_i,
      life_expectancy: LIFE_EXPECTANCY
    }
  end

  private

  def normalised_drawdown_amount
    desired_income.positive? ? desired_income : income_until_life_expectancy
  end

  def tax_free_lump_sum
    pot * TAX_FREE_POT_PORTION
  end

  def taxable_portion
    pot - tax_free_lump_sum
  end

  def years_pot_will_last_for(yearly_drawdown, pot)
    (pot / yearly_drawdown).floor
  end

  def desired_income_with_pot_growth_lasts_until(yearly_drawdown = normalised_drawdown_amount)
    pot_remaining = taxable_portion
    years_lasted = 0

    while pot_remaining.positive?
      pot_remaining *= (GROWTH_INTEREST_RATE + 1)
      pot_remaining -= yearly_drawdown

      years_lasted += 1 if pot_remaining.positive?

      break if years_lasted > 100
    end

    age + years_lasted
  end

  def taxable_portion_with_growth
    years_pot_will_last_without_growth = years_pot_will_last_for(normalised_drawdown_amount, taxable_portion)

    amount_with_growth(taxable_portion, years_pot_will_last_without_growth, normalised_drawdown_amount)
  end

  def income_until_life_expectancy
    yearly_withdrawal_until_death = desired_income

    yearly_withdrawal_until_death = pot if yearly_withdrawal_until_death <= 0

    while desired_income_with_pot_growth_lasts_until(yearly_withdrawal_until_death) < LIFE_EXPECTANCY
      yearly_withdrawal_until_death -= AMOUNT_TO_REDUCE_LIFETIME_PAYMENT_BY

      break if yearly_withdrawal_until_death <= 1
    end

    yearly_withdrawal_until_death
  end

  def monthly_income_until_life_expectancy
    income_until_life_expectancy / 12
  end

  def years_remaining
    LIFE_EXPECTANCY - age
  end

  def amount_with_growth(amount, years, yearly_drawdown)
    amount_before_growth = amount

    1.upto(years) do
      amount -= yearly_drawdown
      amount *= (GROWTH_INTEREST_RATE + 1)
    end

    amount_before_growth + amount
  end
end
