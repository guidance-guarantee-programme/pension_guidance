module Calculators
  ARBITRARY_MULTIPLIER = 5

  class AdjustableIncomeController < CalculatorsController
    def show
      @form = AdjustableIncomeForm.new(form_params)

      return unless request.xhr?
      status = @form.invalid? ? :bad_request : :ok

      render partial: 'calculators/adjustable_income/calculator',
             locals: { form: @form },
             status: status
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
