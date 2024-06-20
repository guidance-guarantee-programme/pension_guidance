RSpec.describe TelephoneCancellation, type: :model do
  subject do
    described_class.new(
      reference: '1234567',
      date_of_birth_year: '1920',
      date_of_birth_month: '01',
      date_of_birth_day: '01'
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
  end
end
