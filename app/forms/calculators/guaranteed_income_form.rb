require 'active_model'

module Calculators
  class GuaranteedIncomeForm
    include ActiveModel::Model

    YOUNGEST_APPLICABLE_AGE = 55
    OLDEST_APPLICABLE_AGE = 75

    attr_reader :pot, :age

    validates :pot, presence: true, numericality: { allow_blank: true, greater_than: 0 }
    validates :age, presence: true, numericality: { allow_blank: true,
                                                    greater_than_or_equal_to: YOUNGEST_APPLICABLE_AGE,
                                                    less_than_or_equal_to: OLDEST_APPLICABLE_AGE }

    def pot=(pot)
      @pot = String(pot).delete(',').squish
    end

    def age=(contribution)
      @age = String(contribution).delete(',').squish
    end

    def estimate
      GuaranteedIncomeCalculator.new(pot: pot.to_f, age: age.to_f).estimate if valid?
    end
  end
end
