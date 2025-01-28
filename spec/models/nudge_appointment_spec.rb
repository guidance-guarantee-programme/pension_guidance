RSpec.describe NudgeAppointment, type: :model do
  subject do
    NudgeAppointment.new(
      start_at: '2022-04-01 11:00 UTC',
      first_name: 'First',
      last_name: 'Last',
      email: 'email@example.org',
      phone: '29309203023',
      memorable_word: 'hello',
      date_of_birth_year: '1920',
      date_of_birth_month: '01',
      date_of_birth_day: '01',
      accessibility_requirements: true,
      notes: 'Some required notes.',
      confirmation: 'email',
      eligibility_reason: '',
      gdpr_consent: 'yes',
      adjustments: 'These are the adjustments'
    )
  end

  it 'defaults `step` to 1' do
    expect(subject.step).to eq(1)
  end

  describe '#save' do
    before do
      allow(api).to receive(:create_nudge).and_return(true)
      allow(TelephoneAppointmentsApi).to receive(:new).and_return(api)
    end

    let(:api) do
      double(:api)
    end

    context 'valid object' do
      it 'stores the object in the api' do
        expect(subject.save).to be_truthy
        expect(api).to have_received(:create_nudge).with(subject)
      end
    end

    context 'invalid object' do
      it 'does not store the object in the api' do
        subject.start_at = nil
        expect(subject.save).to be_falsey
        expect(api).to_not have_received(:create_nudge)
      end
    end
  end

  context 'validations' do
    it 'is valid with valid parameters' do
      expect(subject).to be_valid
    end

    it 'requires GDPR consent to be specified' do
      subject.gdpr_consent = ''

      expect(subject).to be_invalid
    end

    it 'permits any valid age as eligible, within reason' do
      subject.date_of_birth_year = '1980'
      subject.date_of_birth_month = '02'
      subject.date_of_birth_day = '02'

      expect(subject).to be_invalid

      subject.eligibility_reason = 'ill_health'

      expect(subject).to be_valid
    end

    it 'requires a confirmation preference to be specified' do
      subject.confirmation = nil

      expect(subject).to be_invalid
    end

    it 'validates presence of start_at' do
      subject.start_at = nil
      expect(subject).to_not be_valid
    end

    it 'validates presence of first_name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'validates first name does not contain digits' do
      subject.first_name = '07731 292 999'
      expect(subject).to_not be_valid
    end

    it 'validates presence of last_name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'validates last name does not contain digits' do
      subject.last_name = 'Ben 303030'
      expect(subject).to_not be_valid
    end

    context 'when requiring email confirmation' do
      it 'validates presence of email' do
        subject.confirmation = 'email'
        subject.email = nil

        expect(subject).to_not be_valid
      end
    end

    context 'when requiring SMS confirmation' do
      it 'validates presence of mobile' do
        subject.confirmation = 'sms'
        subject.mobile = nil

        expect(subject).to_not be_valid

        subject.mobile = '07715930459'

        expect(subject).to be_valid
      end
    end

    it 'validates format of phone number' do
      ['+447715930459', '(0208) 252 4729', '07715-930-459'].each do |number|
        subject.phone = number
        expect(subject).to be_valid
      end

      ['ben@example.com', '      ', '02089292992e'].each do |number|
        subject.phone = number
        expect(subject).to be_invalid
      end
    end

    it 'validates presence of memorable_word' do
      subject.memorable_word = nil
      expect(subject).to_not be_valid
    end

    it 'validates presence of date_of_birth' do
      subject.date_of_birth_year = nil
      expect(subject).to_not be_valid
    end

    context 'when accessibility requirements are needed' do
      it 'requires adjustments' do
        subject.adjustments = ''
        expect(subject).to_not be_valid
      end
    end

    context 'when accessibility requirements are not needed' do
      it 'does not require adjustments' do
        subject.accessibility_requirements = 'false'
        subject.adjustments = ''

        expect(subject).to be_valid
      end
    end
  end
end
