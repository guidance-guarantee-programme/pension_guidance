class GuaranteedIncomeCalculatorController < ApplicationController
  layout 'guides'

  def show
    @pot = params[:pot]
    @age = params[:age]
    @annuity_type = params[:annuity_type] || 'single'

    calculator = GuaranteedIncomeCalculator.new(@pot.to_i, @age.to_i)
    @tax_free_lump_sum = calculator.tax_free_lump_sum
    @annuity = case @annuity_type
               when 'single' then calculator.single_annuity
               when 'joint' then calculator.joint_annuity
               end
  end
end
