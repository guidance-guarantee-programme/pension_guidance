RSpec.describe Locations::SearchResult do
  let(:id) { 'location-id' }
  let(:name) { 'location name' }
  let(:address) { 'location address' }
  let(:booking_location_id) { 'booking-location-id' }
  let(:phone) { 'phone number' }
  let(:hours) { 'opening hours' }
  let(:lat_lng) { [1, 0] }
  let(:distance) { 150 }
  let(:location) { Locations::Location.new(id, name, address, booking_location_id, phone, hours, lat_lng) }

  subject(:search_result) { described_class.new(location, distance) }

  it { is_expected.to eq(location) }

  specify { expect(search_result.id).to eq(id) }
  specify { expect(search_result.name).to eq(name) }
  specify { expect(search_result.address).to eq(address) }
  specify { expect(search_result.booking_location_id).to eq(booking_location_id) }
  specify { expect(search_result.phone).to eq(phone) }
  specify { expect(search_result.hours).to eq(hours) }
  specify { expect(search_result.lat_lng).to eq(lat_lng) }
  specify { expect(search_result.distance).to eq(distance) }
end
