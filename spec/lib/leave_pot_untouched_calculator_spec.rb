RSpec.describe LeavePotUntouchedCalculator do
  subject(:calculator) { described_class.new(pot: pot, contribution: contribution) }

  let(:pot) { 50_000 }
  let(:contribution) { 75 }

  describe '#result' do
    subject(:result) { calculator.result }

    let(:annual_contribution) { contribution * 12 }
    let(:interest) { 0.03 }

    let(:year_1) { double }
    let(:year_2) { double }
    let(:year_3) { double }
    let(:year_4) { double }
    let(:year_5) { double }

    before do
      allow(Financial).to receive(:future_value).with(pot, annual_contribution, interest, 1) { year_1 }
      allow(Financial).to receive(:future_value).with(pot, annual_contribution, interest, 2) { year_2 }
      allow(Financial).to receive(:future_value).with(pot, annual_contribution, interest, 3) { year_3 }
      allow(Financial).to receive(:future_value).with(pot, annual_contribution, interest, 4) { year_4 }
      allow(Financial).to receive(:future_value).with(pot, annual_contribution, interest, 5) { year_5 }
    end

    it 'returns the estimated pot size for each year' do
      is_expected.to eq([year_1, year_2, year_3, year_4, year_5])
    end
  end
end
