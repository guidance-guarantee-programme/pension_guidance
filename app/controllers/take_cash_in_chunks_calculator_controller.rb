class TakeCashInChunksCalculatorController < ApplicationController
  layout 'guides'

  before_action :set_params

  def show
    @calculator = TakeCashInChunksCalculator.new(@pot.to_i, total_income, @chunk.to_i)
  end

  private

  def set_params
    @pot = params[:pot]
    @income = params[:income]
    @pension = params[:pension]
    @pension_frequency = params[:pension_frequency]
    @chunk = params[:chunk]
  end

  def annual_pension
    return 0 unless @pension_frequency && @pension.is_a?(Numeric)

    case @pension_frequency
    when 'weekly'
      @pension.to_i * 52
    when 'annually'
      @pension.to_i
    end
  end

  def total_income
    @income.to_i + annual_pension
  end
end
