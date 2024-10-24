RSpec.describe TelephoneCancellation, type: :model do
  subject do
    described_class.new(
      reference: '1234567',
      date_of_birth_year: '1920',
      date_of_birth_month: '01',
      date_of_birth_day: '01',
      reason: '32'
    )
  end

  describe 'validation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'requires a valid booking reference' do
      subject.reference = '12 09 09'

      expect(subject).to be_invalid
    end

    it 'requires a valid date of birth' do
      subject.date_of_birth_day = '99'

      expect(subject).to be_invalid
    end

    it 'requires a valid reason' do
      subject.reason = ''

      expect(subject).to be_invalid
    end

    context 'when the reason is Other' do
      it 'requires a valid other reason' do
        subject.reason = '40' # Other
        expect(subject).to be_invalid

        subject.other_reason = 'Because my cat got sick!'
        expect(subject).to be_valid
      end
    end
  end
end
