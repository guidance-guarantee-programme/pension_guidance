class TakeWholePotCalculatorController < ApplicationController
  layout 'guides'

  def show
    @pot = params[:pot]
    @income = params[:income]

    @calculator = TakeWholePotCalculatorForm.new(pot: @pot, income: @income)
    @result = @calculator.result

    return render partial: 'results' if request.xhr?
  end
end
