RSpec.describe AdjustableIncomeCalculator do
  let(:pot) { 200_000 }
  let(:age) { 55 }

  let(:desired_income) {  }

  subject(:calculator) { described_class.new(pot, age) }

  specify { expect(calculator.tax_free_lump_sum).to eq(50_000) }
  specify { expect(calculator.income).to eq(4838.71) }

  context 'when adjusting the desired duration of income' do
    let(:ending_age) { 90 }

    specify { expect(calculator.income_until(ending_age)).to eq(4_285.71) }
  end

  context 'when adjusting the desired income' do
    let(:desired_income) { 5_000 }

    specify { expect(calculator.ending_age_for(desired_income)).to eq(85) }
  end
end
