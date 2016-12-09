require 'active_model'

module Calculators
  class AdjustableIncomeForm
    include ActiveModel::Model

    attr_reader :pot, :age, :desired_monthly_income

    validates :pot, presence: true, numericality: { allow_blank: true,
                                                    greater_than: 0,
                                                    less_than: 5_000_000 }
    validates :age, numericality: { allow_blank: true, greater_than_or_equal_to: 55 }
    validates :desired_monthly_income,
              numericality: { allow_blank: true, greater_than: 0,
                              less_than: ->(form) { form.errors.include?(:pot) ? Float::INFINITY : form.pot.to_f } }

    def pot=(pot)
      @pot = String(pot).delete(',').squish
    end

    def age=(age)
      @age = String(age).delete(',').squish
    end

    def desired_monthly_income=(desired_monthly_income)
      @desired_monthly_income = String(desired_monthly_income).delete(',').squish
    end

    def desired_income
      @desired_monthly_income.to_f * 12
    end

    def estimate
      return unless valid?

      AdjustableIncomeCalculator.new(
        pot: pot.to_f,
        age: age.to_f,
        desired_income: desired_income.to_f
      ).estimate
    end
  end
end
