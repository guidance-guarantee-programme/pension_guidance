class LeavePotUntouchedCalculatorController < ApplicationController
  layout 'guides'

  def show
    @pot = params[:pot].to_i
    @saving = params[:saving].to_i
    @duration = 15
    @interest_rate = 3

    @pot_growth = LeavePotUntouchedCalculator.new(@pot, @saving, @duration, @interest_rate).pot

    return render partial: 'results' if request.xhr?
  end
end
