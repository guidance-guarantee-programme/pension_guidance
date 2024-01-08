require 'active_model'

module Calculators
  class TakeWholePotForm
    include ActiveModel::Model

    Estimate = Struct.new(:pot, :pot_tax, :pot_received)

    attr_reader :pot, :income

    validates :pot, presence: true, numericality: { allow_blank: true, greater_than: 0 }
    validates :income, presence: true, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

    def pot=(pot)
      @pot = String(pot).delete(',').squish
    end

    def income=(income)
      @income = String(income).delete(',').squish
    end

    def estimate
      return unless valid?

      income_tax = IncomeTaxCalculator.new(lump_sum: pot.to_f, income: income.to_f)

      Estimate.new(pot.to_f, income_tax.lump_sum_tax.to_f, income_tax.lump_sum_received.to_f)
    end
  end
end
