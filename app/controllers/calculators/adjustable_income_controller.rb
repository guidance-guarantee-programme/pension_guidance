module Calculators
  class AdjustableIncomeController < CalculatorsController
    def show
      @form = AdjustableIncomeForm.new(form_params)

      render partial: 'calculators/adjustable_income/calculator',
             locals: { form: @form },
             status: (@form.invalid? ? :bad_request : :ok) if request.xhr?
    end

    private

    def id
      'adjustable-income'
    end

    def form_params
      params.permit(:pot, :age, :desired_monthly_income)
    end
  end
end
