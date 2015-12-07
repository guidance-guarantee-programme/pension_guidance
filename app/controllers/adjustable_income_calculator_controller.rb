class AdjustableIncomeCalculatorController < ApplicationController
  layout 'guides'

  def show
    @pot = params[:pot]
    @age = params[:age]

    calculator = AdjustableIncomeCalculator.new(@pot.to_f, @age.to_i)
    @tax_free_lump_sum = calculator.tax_free_lump_sum

    @adjustment = params[:adjustment] || 'age'
    @age_adjustment = params[:age_adjustment]
    @income_adjustment = params[:income_adjustment]

    if @adjustment == 'income'
      @ending_age = AdjustableIncomeCalculator::LIFE_EXPECTANCY
      @income = @income_adjustment
      @ending_age = calculator.ending_age_for(@income_adjustment.to_f)
    else
      @ending_age = (@age_adjustment || AdjustableIncomeCalculator::LIFE_EXPECTANCY).to_i
      @income = calculator.income_until(@ending_age)
    end
  end
end
