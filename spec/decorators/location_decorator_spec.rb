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
  let(:formated_twilio_number) { '01443 643532' }
  let(:location) do
    double(id: id, name: name, address: address,
           booking_location_id: booking_location_id, phone: phone, hours: hours)
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
    specify { expect(decorator.position).to be_nil }
    specify { expect(decorator.distance).to be_nil }

    context 'and we are proxying their phone number through twilio' do
      subject(:decorator) { described_class.new(location, twilio_number: twilio_number) }

      specify { expect(decorator.phone).to eq(formated_twilio_number) }
    end
  end

  context 'with a separate booking location' do
    subject(:decorator) { described_class.new(location, booking_location: booking_location) }

    specify { expect(decorator.name).to eq(name) }
    specify { expect(decorator.address).to eq(address) }
    specify { expect(decorator.phone).to eq(booking_location_phone) }
    specify { expect(decorator.hours).to eq(booking_location_hours) }
    specify { expect(decorator.booking_location).to eq(booking_location_name) }

    specify { expect(decorator.position).to be_nil }
    specify { expect(decorator.distance).to be_nil }

    context 'and we are proxying their phone number through twilio' do
      subject(:decorator) do
        described_class.new(
          location, booking_location: booking_location, twilio_number: twilio_number)
      end

      specify { expect(decorator.phone).to eq(formated_twilio_number) }
    end
  end

  context 'with nearest locations' do
    subject(:decorator) { described_class.new(location, nearest_locations: nearest_locations) }

    let(:nearest_locations) { [double(id: double), double(id: id, distance: 10.1)] }

    specify { expect(decorator.position).to eq(2) }
    specify { expect(decorator.distance).to eq('10.10') }
  end
end
