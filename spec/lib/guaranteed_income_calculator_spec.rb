RSpec.describe GuaranteedIncomeCalculator do
  let(:pot) { 133_333 }

  subject(:calculator) { described_class.new(pot) }

  specify { expect(calculator.tax_free_lump_sum).to eq(33_333.25) }
end
