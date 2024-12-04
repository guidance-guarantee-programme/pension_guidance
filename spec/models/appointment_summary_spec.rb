RSpec.describe AppointmentSummary, type: :model do
  describe 'validation' do
    subject { described_class.new(appointment_type: 'standard', urn: 'PAB1-2ABC') }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    describe '#urn' do
      it 'permits empty or nil values' do
        subject.urn = nil
        expect(subject).to be_valid

        subject.urn = ''
        expect(subject).to be_valid
      end

      it 'requires a valid form' do
        subject.urn = 'This would really suck if it were to get through!'
        expect(subject).to be_invalid
      end
    end
  end
end
