module Calculators
  class TakeWholePotController < CalculatorsController
    def show
      @pot = form_params[:pot]
      @income = form_params[:income]

      @calculator = TakeWholePotCalculatorForm.new(form_params)

      render partial: 'calculators/take_whole_pot/calculator',
             locals: { calculator: @calculator, pot: @pot, income: @income },
             status: (@calculator.invalid? ? :bad_request : :ok) if request.xhr?
    end

    private

    def id
      'take-whole-pot'
    end

    def form_params
      params.permit(:pot, :income)
    end
  end
end
