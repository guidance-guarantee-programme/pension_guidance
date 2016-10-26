RSpec.describe Locations::SearchResult do
  let(:id) { 'location-id' }
  let(:name) { 'location name' }
  let(:address) { 'location address' }
  let(:booking_location_id) { 'booking-location-id' }
  let(:phone) { 'phone number' }
  let(:twilio_number) { 'twilio number' }
  let(:hours) { 'opening hours' }
  let(:lat_lng) { [1, 0] }
  let(:distance) { 150 }
  let(:location) do
    Locations::Location.new(
      id: id,
      name: name,
      address: address,
      booking_location_id: booking_location_id,
      phone: phone,
      hours: hours,
      twilio_number: twilio_number,
      online_booking_enabled: false,
      lat_lng: lat_lng
    )
  end

  subject(:search_result) { described_class.new(location, distance) }

  it { is_expected.to eq(location) }

  specify { expect(search_result.id).to eq(id) }
  specify { expect(search_result.name).to eq(name) }
  specify { expect(search_result.address).to eq(address) }
  specify { expect(search_result.booking_location_id).to eq(booking_location_id) }
  specify { expect(search_result.phone).to eq(phone) }
  specify { expect(search_result.hours).to eq(hours) }
  specify { expect(search_result.twilio_number).to eq(twilio_number) }
  specify { expect(search_result.lat_lng).to eq(lat_lng) }
  specify { expect(search_result.distance).to eq(distance) }
end
