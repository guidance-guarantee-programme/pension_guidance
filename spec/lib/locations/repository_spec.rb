RSpec.describe Locations::Repository do
  let(:path) { Rails.root.join('spec/fixtures/locations.json') }
  let(:name) { 'Belfast Citizens Advice Bureau' }
  let(:address) { 'Merrion Business Centre, 58 Howard St, Belfast, BT1 6PJ' }
  let(:booking_location_id) { '928543c7-e8f0-45b2-a300-c2f996b007d9' }
  let(:phone) { '0300 1 233 233' }
  let(:lat_lng) { [54.5957306, -5.9341485] }
  let(:location) { locations.first }
  let(:repository) { described_class.new(path) }

  subject(:locations) { repository.all }

  specify { expect(locations.count).to eq(1) }
  specify { expect(location.name).to eq(name) }
  specify { expect(location.address).to eq(address) }
  specify { expect(location.booking_location_id).to eq(booking_location_id) }
  specify { expect(location.phone).to eq(phone) }
  specify { expect(location.lat_lng).to eq(lat_lng) }
  specify { expect(location.accessibility_information).to eq('Some stuff') }

  describe '#find' do
    let(:id) { 'invalid' }

    subject(:result) { repository.find(id) }

    context 'with an invalid id' do
      it { is_expected.to be_nil }
    end

    context 'with an valid id' do
      let(:id) { '704cb1cf-82ad-4051-9a93-abe01a851584' }

      specify { expect(result).to be_a(Locations::Location) }
      specify { expect(result.id).to eq(id) }
    end
  end
end
