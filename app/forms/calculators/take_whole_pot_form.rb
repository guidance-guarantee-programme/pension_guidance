require 'active_model'

module Calculators
  class TakeWholePotForm
    include ActiveModel::Model

    attr_accessor :pot, :income

    validates :pot, presence: true, numericality: { allow_blank: true, greater_than: 0 }
    validates :income, presence: true, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

    def pot
      Float(@pot.delete(',')) rescue @pot
    end

    def income
      Float(@income.delete(',')) rescue @income
    end

    def estimate
      IncomeTaxCalculator.new(lump_sum: pot, income: income) if valid?
    end
  end
end
