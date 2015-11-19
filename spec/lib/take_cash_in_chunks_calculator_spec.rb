RSpec.describe TakeCashInChunksCalculator do
  let(:pot) { 200_000 }
  let(:income) { 10_000 }
  let(:chunk) { 50_000 }

  subject(:calculator) { described_class.new(pot, income, chunk) }

  specify { expect(calculator.pot_tax).to eq(8_403) }
  specify { expect(calculator.pot_received).to eq(41_597) }
  specify { expect(calculator.pot_remaining).to eq(150_000) }
end
