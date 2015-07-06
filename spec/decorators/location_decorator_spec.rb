RSpec.describe LocationDecorator do
  let(:name) { 'location name' }
  let(:address) { 'location address' }
  let(:booking_location_id) { 'booking-location-id' }
  let(:phone) { 'phone number' }
  let(:hours) { 'opening hours' }
  let(:booking_location_name) { 'booking location name' }
  let(:booking_location_phone) { 'booking location phone number' }
  let(:booking_location_hours) { 'booking location opening hours' }
  let(:location) do
    double(name: name, address: address, booking_location_id: booking_location_id,
           phone: phone, hours: hours)
  end
  let(:booking_location) do
    double(name: booking_location_name, phone: booking_location_phone, hours: booking_location_hours)
  end

  context 'without a separate booking location' do
    subject(:decorator) { described_class.new(location) }

    specify { expect(decorator.name).to eq(name) }
    specify { expect(decorator.address).to eq(address) }
    specify { expect(decorator.phone).to eq(phone) }
    specify { expect(decorator.hours).to eq(hours) }
    specify { expect(decorator.booking_location).to be_nil }
  end

  context 'with a separate booking location' do
    subject(:decorator) { described_class.new(location, booking_location) }

    specify { expect(decorator.name).to eq(name) }
    specify { expect(decorator.address).to eq(address) }

    specify { expect(decorator.phone).to eq(booking_location_phone) }
    specify { expect(decorator.hours).to eq(booking_location_hours) }
    specify { expect(decorator.booking_location).to eq(booking_location_name) }
  end
end
