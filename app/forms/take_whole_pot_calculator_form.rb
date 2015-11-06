require 'active_model'

class TakeWholePotCalculatorForm
  include ActiveModel::Model

  WEEKS_PER_YEAR = 52

  attr_accessor :pot, :income, :pension, :pension_frequency

  validates :pot, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :income, numericality: true
  validates :pension, numericality: true
  validates :pension_frequency, inclusion: { in: %w(weekly annually) }

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

  def total_income
    annual_pension = case pension_frequency
                     when 'weekly'
                       pension * WEEKS_PER_YEAR
                     when 'annually'
                       pension
                     end
    income + annual_pension
  end
end
