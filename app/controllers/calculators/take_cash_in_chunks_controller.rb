module Calculators
  class TakeCashInChunksController < CalculatorsController
    def show
      @form = TakeCashInChunksForm.new(form_params)

      render partial: 'calculators/take_cash_in_chunks/calculator',
             locals: { form: @form },
             status: (@form.invalid? ? :bad_request : :ok) if request.xhr?
    end

    private

    def id
      'take-cash-in-chunks'
    end

    def form_params
      params.permit(:pot, :income, :chunk)
    end
  end
end
