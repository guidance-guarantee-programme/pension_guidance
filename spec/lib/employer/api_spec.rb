RSpec.describe Employer::Api do
  describe '#create', vcr: true do
    it 'responds successfully' do
      booking = Employer::Booking.new(
        location_id: 1,
        start_at: '2019-05-10 06:00 UTC',
        first_name: 'Rick',
        last_name: 'Sanchez',
        email: 'rick@example.com',
        phone: '07715 930 444',
        memorable_word: 'cheese',
        date_of_birth_year: '1960',
        date_of_birth_month: '01',
        date_of_birth_day: '01',
        dc_pot_confirmed: true,
        gdpr_consent: nil
      )

      described_class.new.create(booking)

      expect(booking.id).to eq(4843)
      expect(booking.room).to eq('Room no.1')
    end
  end

  describe '#employer', vcr: true do
    subject { described_class.new.employer(1) }

    it 'returns deserialized employer and locations' do
      expect(subject['name']).to eq('Tesco')

      expect(subject['locations'].first).to include(
        'name' => 'Tesco 1',
        'address_line_one' => '1 Some Street',
        'address_line_two' => 'Some Place',
        'town' => 'Some Town',
        'county' => 'Some County',
        'available' => true
      )
    end
  end

  describe '#location', vcr: true do
    subject { described_class.new.location(1) }

    it 'returns deserialized slots' do
      expect(subject).to be_present
      expect(subject['windowed_slots'].keys).to match_array(
        %w(2019-05-10 2019-05-13 2019-05-17)
      )
    end
  end
end
