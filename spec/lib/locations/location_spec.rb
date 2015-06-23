RSpec.describe Locations::Location do
  let(:name) { 'Local & Beyond - CAB' }

  subject(:location) { described_class.new(name, 'address', 'phone', 'hours', [1, 0]) }

  specify { expect(location.id).to eq('local-beyond-cab') }
end
