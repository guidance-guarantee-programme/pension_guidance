module Calculators
  class GuaranteedIncomeController < CalculatorsController
    def show
      @form = GuaranteedIncomeForm.new(form_params)

      render partial: 'calculators/guaranteed_income/calculator',
             locals: { form: @form },
             status: (@form.invalid? ? :bad_request : :ok) if request.xhr?
    end

    private

    def id
      'guaranteed_income'
    end

    def form_params
      params.permit(:pot, :age)
    end
  end
end
