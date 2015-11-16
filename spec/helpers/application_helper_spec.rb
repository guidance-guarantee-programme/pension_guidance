RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_currency' do
    specify { expect(helper.format_currency(1_000_000)).to eq('£1,000,000') }
    specify { expect(helper.format_currency(1_000.50)).to eq('£1,000.50') }
  end
end
