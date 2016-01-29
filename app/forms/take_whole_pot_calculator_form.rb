require 'active_model'

class TakeWholePotCalculatorForm
  include ActiveModel::Model

  attr_accessor :pot, :income

  validates :pot, presence: true, numericality: { allow_blank: true, greater_than: 0 }
  validates :income, presence: true, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

  def pot
    Float(@pot.gsub(/,/, '')) rescue @pot
  end

  def income
    Float(@income.gsub(/,/, '')) rescue @income
  end

  def result
    TakeWholePotCalculator.new(pot, income) if valid?
  end
end
