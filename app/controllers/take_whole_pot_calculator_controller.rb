class TakeWholePotCalculatorController < ApplicationController
  layout 'guides'

  before_action :set_params

  def show
    result = TakeWholePotCalculator.new(@pot, total_income)
    @pot_received = result.pot_received
    @pot_tax = result.pot_tax
  end

  private

  def set_params
    @pot = params[:pot].to_i
    @income = params[:income].to_i
    @pension = params[:pension].to_i
    @pension_frequency = params[:pension_frequency]
  end

  def total_income
    annual_pension = case @pension_frequency
                     when 'weekly'
                       @pension * 52
                     when 'annually'
                       @pension
                     end
    @income + annual_pension
  end
end
