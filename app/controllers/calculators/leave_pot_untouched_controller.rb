module Calculators
  class LeavePotUntouchedController < CalculatorsController
    def show
      @form = LeavePotUntouchedForm.new(form_params)

      render partial: 'calculators/leave_pot_untouched/calculator',
             locals: { form: @form },
             status: (@form.invalid? ? :bad_request : :ok) if request.xhr?
    end

    private

    def id
      'leave-pot-untouched'
    end

    def form_params
      params.permit(:pot, :contribution)
    end
  end
end
