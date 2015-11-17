RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_currency' do
    subject(:formatted_currency) { helper.format_currency(currency) }

    context 'with a whole number' do
      let(:currency) { 1_000_000 }

      it 'removes the decimal digits' do
        expect(formatted_currency).to eq('£1,000,000')
      end
    end

    context 'with a decimal number' do
      let(:currency) { 1_000.50 }

      it 'persists the decimal digits' do
        expect(formatted_currency).to eq('£1,000.50')
      end
    end
  end
end
