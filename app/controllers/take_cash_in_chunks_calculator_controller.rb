class TakeCashInChunksCalculatorController < ApplicationController
  layout 'guides'

  def show
    @pot = params[:pot]
    @income = params[:income]
    @chunk = params[:chunk]

    @calculator = TakeCashInChunksCalculator.new(@pot.to_i, @income.to_i, @chunk.to_i)
  end
end
