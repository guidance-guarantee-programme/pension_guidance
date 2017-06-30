RSpec.describe Locations::Search, '.nearest_to' do
  let(:london) { TestLocation.london }
  let(:paris) { TestLocation.paris }
  let(:new_york) { TestLocation.new_york }
  let(:belfast) { [54.597269, -5.930109] }
  let(:locations) { [new_york, paris, london] }
  let(:radius) { nil }
  let(:limit) { 5 }

  subject(:results) { described_class.nearest_to(locations, belfast, limit: limit, radius: radius) }

  it { is_expected.to eq([london, paris, new_york]) }

  context 'when limiting results' do
    let(:limit) { 2 }

    subject { results.count }

    it { is_expected.to eq(limit) }
  end

  context 'when restricting by distance' do
    let(:radius) { 1000 }

    it 'returns the results with expected locations' do
      locations = results.collect(&:__getobj__)
      expect(locations).to eq([london, paris])
    end
  end
end
