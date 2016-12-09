module Calculators
  class TakeWholePotController < CalculatorsController
    def show
      @form = TakeWholePotForm.new(form_params)

      return unless request.xhr?
      render partial: 'calculators/take_whole_pot/calculator',
             locals: { form: @form },
             status: (@form.invalid? ? :bad_request : :ok)
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
