RSpec.describe Locations::Search, '.nearest_to' do
  let(:london) { Locations::Location.new('London', '', '', '', [51.500152, -0.126236]) }
  let(:paris) { Locations::Location.new('Paris', '', '', '', [48.85666, 2.350987]) }
  let(:new_york) { Locations::Location.new('New York', '', '', '', [40.714269, 74.005973]) }
  let(:belfast) { [54.597269, -5.930109] }
  let(:locations) { [new_york, paris, london] }
  let(:limit) { 5 }

  subject(:results) { described_class.nearest_to(locations, belfast, limit) }

  it { is_expected.to eq([london, paris, new_york]) }

  context 'when limiting results' do
    let(:limit) { 2 }

    subject { results.count }

    it { is_expected.to eq(limit) }
  end
end
