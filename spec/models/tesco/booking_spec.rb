RSpec.describe Tesco::Booking do
  describe '#age_at_appointment' do
    context 'when `date_of_birth` is not present' do
      it 'returns 0' do
        expect(described_class.new.age_at_appointment).to be_zero
      end
    end

    context 'when it can be calculated' do
      subject do
        described_class.new(
          date_of_birth_year: '1967',
          date_of_birth_month: '02',
          date_of_birth_day: '02',
          start_at: '2017-11-05 13:00UTC'
        )
      end

      it 'returns the correct age at appointment' do
        expect(subject.age_at_appointment).to eq(50)
      end
    end
  end
end
