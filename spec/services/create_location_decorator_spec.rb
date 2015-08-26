RSpec.describe CreateLocationDecorator, '.build' do
  let(:postcode) { 'BT7 3AP' }
  let(:search_limit) { 3 }
  let(:booking_location_id) { 222 }
  let(:booking_location) { double(id: booking_location_id) }
  let(:location_id) { 111 }
  let(:location) { double(id: location_id, booking_location_id: booking_location_id) }
  let(:nearest_locations) { double }
  let(:search_context) { double }
  let(:twilio_number) { double }
  let(:location_decorator) { double }

  def create_decorator
    described_class.build(location: location,
                          postcode: postcode,
                          search_limit: search_limit)
  end

  subject(:decorator) { create_decorator }

  before do
    allow(Locations).to receive(:find).with(booking_location_id).and_return(booking_location)
    allow(Locations).to receive(:nearest_to_postcode).with(postcode, limit: search_limit).and_return(nearest_locations)
    allow(LocationSearchContext).to receive(:build).with(nearest_locations, location).and_return(search_context)
    allow(Switchboard).to receive(:lookup).with(location_id).and_return(twilio_number)
    expect(LocationDecorator).to receive(:new).with(
      location, booking_location: booking_location, search_context: search_context, twilio_number: twilio_number
    ).and_return(location_decorator)
  end

  it { should eq(location_decorator) }

  context 'without a seperate booking location' do
    let(:booking_location_id) { nil }
    let(:booking_location) { nil }

    it 'does not retrieve the booking location' do
      expect(Locations).to_not receive(:find)
      create_decorator
    end
  end

  context 'when the cab locator raises an exception' do
    let(:nearest_locations) { nil }

    before do
      allow(Locations).to receive(:nearest_to_postcode) { fail }
    end

    it 'handles the exception' do
      expect { create_decorator }.not_to raise_error
    end
  end
end
