module Calculators
  class TakeWholePotController < CalculatorsController
    def show
      @pot = params[:pot]
      @income = params[:income]

      @calculator = TakeWholePotCalculatorForm.new(pot: @pot, income: @income)

      render partial: 'calculators/take_whole_pot/calculator',
             locals: { calculator: @calculator, pot: @pot, income: @income },
             status: (@calculator.invalid? ? :bad_request : :ok) if request.xhr?
    end

    private

    def id
      'take-whole-pot'
    end
  end
end
