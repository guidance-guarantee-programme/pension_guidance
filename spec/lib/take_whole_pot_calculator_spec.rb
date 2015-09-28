RSpec.describe TakeWholePotCalculator do
  describe '.personal_allowance_for' do
    let(:income) { 0 }

    subject(:personal_allowance) { described_class.personal_allowance_for(income) }

    context 'when £100,000 and below total income' do
      let(:income) { 100_000 }

      it { is_expected.to eq(10_600) }
    end

    context 'when between £100,000 and £121,200 total income' do
      let(:income) { 110_000 }

      it { is_expected.to eq(5_600) }
    end

    context 'when £121,200 and above total income' do
      let(:income) { 122_000 }

      it { is_expected.to eq(0) }
    end
  end
end
