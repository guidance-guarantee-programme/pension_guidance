class TakeWholePotCalculatorController < ApplicationController
  layout 'guides'

  def show
    @pot = params[:pot]
    @income = params[:income]
    @pension = params[:pension]
    @pension_frequency = params[:pension_frequency]

    @calculator = TakeWholePotCalculatorForm.new(
      pot: @pot, income: @income, pension: @pension,
      pension_frequency: @pension_frequency)
    @result = @calculator.result

    return render partial: 'results' if request.xhr?
  end
end
