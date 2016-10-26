RSpec.describe Locations::Search, '.nearest_to' do
  let(:london) { TestLocation.london }
  let(:paris) { TestLocation.paris }
  let(:new_york) { TestLocation.new_york }
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
