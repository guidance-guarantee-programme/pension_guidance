class TakeWholePotCalculatorController < GuidesController
  def show
    @pot = params[:pot]
    @income = params[:income]

    @calculator = TakeWholePotCalculatorForm.new(pot: @pot, income: @income)
  end

  private

  def id
    'take-whole-pot'
  end
end
