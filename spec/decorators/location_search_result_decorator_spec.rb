RSpec.describe LocationSearchResultDecorator do
  let(:distance) { 1.0489736864844752 }
  let(:search_result) { double(distance: distance, lat_lng: [123, 456]) }

  subject(:decorator) { described_class.new(search_result) }

  specify { expect(decorator.distance).to eq('1.05') }

  it 'returns coordinates' do
    expect(decorator.coordinates).to eq('123,456')
  end
end
