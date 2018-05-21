RSpec.describe Tesco::Api do
  describe '#create', vcr: true do
    it 'responds successfully' do
      booking = Tesco::Booking.new(
        location_id: 1,
        start_at: '2018-05-25 07:00 UTC',
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

      expect(booking.id).to eq(299)
      expect(booking.room).to eq('HIGH 2.2')
    end
  end

  describe '#locations', vcr: true do
    subject { described_class.new.locations }

    it 'returns deserialized locations' do
      expect(subject).to be_present
      expect(subject.first.values).to include(
        'Tesco 1',
        '1 Some Street',
        'Some Place',
        'Some Town',
        'Some County'
      )
    end
  end

  describe '#location', vcr: true do
    subject { described_class.new.location(1) }

    it 'returns deserialized slots' do
      expect(subject).to be_present
      expect(subject['windowed_slots'].keys).to match_array(
        %w(2017-09-12 2017-09-13 2017-09-14 2017-09-15)
      )
    end
  end
end
