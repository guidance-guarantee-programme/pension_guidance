RSpec.describe Locations::Repository do
  let(:path) { Rails.root.join('spec', 'fixtures', 'locations.json') }
  let(:name) { 'Belfast Citizens Advice Bureau' }
  let(:address) { 'Merrion Business Centre, 58 Howard St, Belfast, BT1 6PJ' }
  let(:phone) { '0300 1 233 233' }
  let(:lat_lng) { [54.5957306, -5.9341485] }
  let(:location) { locations.first }

  subject(:locations) { described_class.new(path).all }

  specify { expect(locations.count).to eq(1) }
  specify { expect(location.name).to eq(name) }
  specify { expect(location.address).to eq(address) }
  specify { expect(location.phone).to eq(phone) }
  specify { expect(location.lat_lng).to eq(lat_lng) }
end
