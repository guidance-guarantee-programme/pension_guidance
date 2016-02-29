module Calculators
  class GuaranteedIncomeController < CalculatorsController
    def show
      @form = GuaranteedIncomeForm.new(form_params)

      if request.xhr?
        status = @form.invalid? ? :bad_request : :ok

        render partial: 'calculators/guaranteed_income/calculator',
               locals: { form: @form },
               status: status
      end
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
