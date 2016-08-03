require 'active_model'

module Calculators
  class AnnuityForm
    LIFE_EXPECTANCY = AdjustableIncomeCalculator::LIFE_EXPECTANCY
    MAX_AGE = 115
    MIN_AGE = 55

    include ActiveModel::Model

    attr_reader :age, :pension_income, :income

    validates :age, numericality: { greater_than_or_equal_to: MIN_AGE }
    validates :life_expectancy, numericality: { allow_blank: true }
    validates :pension_income, numericality: { greater_than_or_equal_to: 0 }
    validates :income, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

    def age=(age)
      @age = String(age).delete(',').squish
    end

    def life_expectancy=(life_expectancy)
      @life_expectancy = String(life_expectancy).delete(',').squish
    end

    def life_expectancy
      @life_expectancy.presence || LIFE_EXPECTANCY
    end

    def pension_income=(pension_income)
      @pension_income = String(pension_income).delete(',').squish
    end

    def income=(income)
      @income = String(income).delete(',').squish
    end

    def estimate
      if valid?
        AnnuityCalculator.new(
          age: age.to_i,
          income: income.to_f,
          pension_income: pension_income.to_f,
          life_expectancy: life_expectancy.to_i
        ).estimate
      end
    end
  end
end
