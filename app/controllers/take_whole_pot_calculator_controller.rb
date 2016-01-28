class TakeWholePotCalculatorController < GuidesController
  def show
    @pot = params[:pot]
    @income = params[:income]

    @calculator = TakeWholePotCalculatorForm.new(pot: @pot, income: @income)
    @result = @calculator.result
  end

  private

  def id
    'take-whole-pot'
  end
end
