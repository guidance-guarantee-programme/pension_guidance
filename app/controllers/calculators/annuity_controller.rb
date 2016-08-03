module Calculators
  class AnnuityController < CalculatorsController
    def show
      @form = AnnuityForm.new(form_params)

      if request.xhr?
        status = @form.invalid? ? :bad_request : :ok

        render partial: 'calculators/annuity/calculator',
               locals: { form: @form },
               status: status
      end
    end

    private

    def id
      'how-to-sell-an-annuity'
    end

    def form_params
      params.permit(:age, :life_expectancy, :pension_income, :income)
    end
  end
end
