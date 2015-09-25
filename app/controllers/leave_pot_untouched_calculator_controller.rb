class LeavePotUntouchedCalculatorController < ApplicationController
  layout 'guides'

  def show
    @pot = params[:pot].to_i
    @saving = params[:saving].to_i
    @duration = params[:duration].to_i
    @interest_rate = 3

    @final_pot = LeavePotUntouchedCalculator.new(@pot, @saving, @duration, @interest_rate).pot

    return render partial: 'results' if request.xhr?
  end
end
