RSpec.describe LocationDecorator do
  let(:id) { 'location-id' }
  let(:name) { 'location name' }
  let(:address) { 'location address' }
  let(:booking_location_id) { 'booking-location-id' }
  let(:phone) { 'phone number' }
  let(:hours) { 'opening hours' }
  let(:booking_location_name) { 'booking location name' }
  let(:booking_location_phone) { 'booking location phone number' }
  let(:booking_location_hours) { 'booking location opening hours' }
  let(:twilio_number) { '+441443643532' }
  let(:formatted_twilio_number) { '01443 643532' }
  let(:location) do
    double(
      :location,
      id: id,
      name: name,
      address: address,
      booking_location_id: booking_location_id,
      phone: phone,
      hours: hours,
      twilio_number: twilio_number
    )
  end
  let(:booking_location) do
    double(name: booking_location_name, phone: booking_location_phone, hours: booking_location_hours)
  end

  context 'without a separate booking location' do
    subject(:decorator) { described_class.new(location) }

    specify { expect(decorator.name).to eq(name) }
    specify { expect(decorator.address).to eq(address) }
    specify { expect(decorator.hours).to eq(hours) }
    specify { expect(decorator.booking_location).to be_nil }
    specify { expect(decorator.phone).to eq(formatted_twilio_number) }
  end

  context 'with a separate booking location' do
    subject(:decorator) { described_class.new(location, booking_location: booking_location) }

    specify { expect(decorator.name).to eq(name) }
    specify { expect(decorator.address).to eq(address) }
    specify { expect(decorator.hours).to eq(booking_location_hours) }
    specify { expect(decorator.booking_location).to eq(booking_location_name) }
    specify { expect(decorator.phone).to eq(formatted_twilio_number) }
  end
end
