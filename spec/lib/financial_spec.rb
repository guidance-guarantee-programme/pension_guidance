RSpec.describe Financial do
  describe '.future_value' do
    subject do
      described_class.future_value(principal_amount, additional_amount,
                                   nominal_interest_rate, compounding_frequency, time)
    end

    let(:principal_amount) { 25_000 }
    let(:additional_amount) { 150 }
    let(:nominal_interest_rate) { 0.03 }
    let(:compounding_frequency) { 12 }
    let(:time) { 5 }

    it { is_expected.to eq(38_737.426432197986) }
  end
end
