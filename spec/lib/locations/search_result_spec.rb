RSpec.describe Locations::SearchResult do
  let(:name) { 'location name' }
  let(:lat_lng) { [1, 0] }
  let(:distance) { 150 }
  let(:location) { Locations::Location.new(name, lat_lng) }

  subject(:search_result) { described_class.new(location, distance) }

  it { is_expected.to eq(location) }

  specify { expect(search_result.name).to eq(name) }
  specify { expect(search_result.lat_lng).to eq(lat_lng) }
  specify { expect(search_result.distance).to eq(distance) }
end
