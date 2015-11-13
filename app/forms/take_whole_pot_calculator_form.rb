require 'active_model'

class TakeWholePotCalculatorForm
  include ActiveModel::Model

  MAXIMUM_STATE_PENSION = 10_400
  WEEKS_PER_YEAR = 52

  attr_accessor :pot, :income, :pension, :pension_frequency

  validates :pot, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :income, numericality: true
  validates :pension, numericality: true
  validates :pension_frequency, inclusion: { in: %w(weekly annually) }
  validate :within_state_pension_limit

  def pot
    Float(@pot.gsub(/,/, '')) rescue @pot
  end

  def income
    Float(@income.gsub(/,/, '')) rescue @income
  end

  def pension
    Float(@pension.gsub(/,/, '')) rescue @pension
  end

  def result
    TakeWholePotCalculator.new(pot, total_income) if valid?
  end

  private

  def within_state_pension_limit
    errors.add(:pension, :above_limit) if annual_pension > MAXIMUM_STATE_PENSION
  end

  def annual_pension
    return 0 unless pension_frequency && pension

    case pension_frequency
    when 'weekly'
      pension * WEEKS_PER_YEAR
    when 'annually'
      pension
    end
  end

  def total_income
    income + annual_pension
  end
end
