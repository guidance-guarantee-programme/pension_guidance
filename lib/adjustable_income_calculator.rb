class AdjustableIncomeCalculator
  # https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/lifeexpectancies/bulletins/lifeexpectancyatbirthandatage65bylocalareasinenglandandwales/2015-11-04#national-life-expectancy-at-age-65
  LIFE_EXPECTANCY = 84
  TAX_FREE_POT_PORTION = 0.25
  GROWTH_INTEREST_RATE = 0.03

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
      desired_income_with_pot_growth_lasts_until: desired_income_with_pot_growth_lasts_until.to_i,
      monthly_income_until_life_expectancy: monthly_income_until_life_expectancy.to_i,
      life_expectancy: LIFE_EXPECTANCY
    }
  end

  private

  def tax_free_lump_sum
    pot * TAX_FREE_POT_PORTION
  end

  def taxable_portion
    pot - tax_free_lump_sum
  end

  def years_pot_will_last_for(desired_income, pot)
    (pot / desired_income).floor
  end

  def desired_income_with_pot_growth_lasts_until(yearly_withdrawal = desired_income)
    pot_remaining = taxable_portion
    years_lasted = 0

    while pot_remaining > 0
      pot_remaining *= (GROWTH_INTEREST_RATE + 1)
      pot_remaining -= yearly_withdrawal

      years_lasted += 1 if pot_remaining > 0

      break if years_lasted > 100
    end

    age + years_lasted
  end

  def taxable_portion_with_growth
    years_pot_will_last_without_growth = years_pot_will_last_for(desired_income, taxable_portion)

    amount_with_growth(taxable_portion, years_pot_will_last_without_growth, desired_income)
  end

  def income_until_life_expectancy
    yearly_withdrawal_until_death = desired_income

    while desired_income_with_pot_growth_lasts_until(yearly_withdrawal_until_death) < LIFE_EXPECTANCY
      yearly_withdrawal_until_death -= 10

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

  def amount_with_growth(amount, years, yearly_withdrawal)
    amount_before_growth = amount

    1.upto(years) do
      amount -= yearly_withdrawal
      amount *= (GROWTH_INTEREST_RATE + 1)
    end

    amount_before_growth + amount
  end
end
