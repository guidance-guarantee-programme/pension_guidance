RSpec.describe TelephoneAppointment, type: :model do
  subject do
    TelephoneAppointment.new(
      start_at: '2200-01-01 11:46:24 UTC',
      first_name: 'First',
      last_name: 'Last',
      email: 'email@example.org',
      phone: '29309203023',
      memorable_word: 'hello',
      date_of_birth_year: '1920',
      date_of_birth_month: '01',
      date_of_birth_day: '01',
      dc_pot_confirmed: 'yes',
      where_you_heard: '1',
      gdpr_consent: 'yes',
      accessibility_requirements: '1',
      adjustments: 'I require walking assistance',
      notes: 'meh',
      smarter_signposted: 'true',
      nudged: 'false',
      embedded: 'false',
      rebooked_from_id: '1234567'
    )
  end

  it 'defaults `country_of_residence` to GB' do
    expect(subject.country_of_residence).to eq('GB')
  end

  it 'defaults `due_diligence?` to false' do
    expect(subject).not_to be_due_diligence
  end

  it 'defaults `step` to 1' do
    expect(subject.step).to eq(1)
  end

  describe '#where_you_heard' do
    context 'when `embedded?`' do
      it 'defaults to the nudge embed where you heard value' do
        subject.embedded = 'true'

        expect(subject.where_you_heard).to eq('25')
      end
    end
  end

  describe '#save' do
    before do
      allow(api).to receive(:create).and_return(true)
      allow(TelephoneAppointmentsApi).to receive(:new).and_return(api)
    end

    let(:api) do
      double(:api)
    end

    context 'valid object' do
      it 'stores the object in the api' do
        expect(subject.save).to be_truthy
        expect(api).to have_received(:create).with(subject)
      end
    end

    context 'invalid object' do
      it 'does not store the object in the api' do
        subject.start_at = nil
        expect(subject.save).to be_falsey
        expect(api).to_not have_received(:create)
      end
    end
  end

  context '#eligible?' do
    context 'without a dc pot' do
      it 'is ineligible' do
        subject.dc_pot_confirmed = 'no'
        expect(subject).to_not be_eligible
      end
    end

    context 'with a dc pot' do
      it 'is eligible' do
        subject.dc_pot_confirmed = 'yes'
        expect(subject).to be_eligible
      end
    end

    context 'unsure of dc pot' do
      it 'is eligible' do
        subject.dc_pot_confirmed = 'yes'
        expect(subject).to be_eligible
      end
    end

    context 'older than 50' do
      it 'is eligible' do
        subject.date_of_birth_year = '1950'

        expect(subject).to be_eligible
      end
    end

    context 'without a start_at' do
      it 'is ineligible' do
        subject.start_at = nil

        expect(subject).to_not be_eligible
      end
    end

    context 'exactly 50' do
      it 'is eligible' do
        subject.date_of_birth_year = '2150'
        subject.date_of_birth_month = '01'
        subject.date_of_birth_day = '01'

        expect(subject).to be_eligible
      end
    end

    context 'younger than 50' do
      it 'is ineligible' do
        subject.date_of_birth_year = '2150'
        subject.date_of_birth_month = '01'
        subject.date_of_birth_day = '02'

        expect(subject).to_not be_eligible
      end
    end
  end

  context 'validations' do
    it 'is valid with valid parameters' do
      expect(subject).to be_valid
    end

    context 'when it is a due diligence appointment' do
      before do
        subject.schedule_type = 'due_diligence'
        subject.referrer = 'Big Pensions PLC'
        subject.country_of_residence = 'GB'
      end

      it 'requires the referring pension provider' do
        subject.referrer = ''
        expect(subject).to be_invalid

        subject.referrer = 'Big Pensions PLC'
        expect(subject).to be_valid
      end

      it 'permits any valid age as eligible' do
        subject.date_of_birth_year = '1980'
        subject.date_of_birth_month = '02'
        subject.date_of_birth_day = '02'

        expect(subject).to be_valid
        expect(subject).to be_eligible
      end
    end

    it 'validates inclusion of GDPR consent' do
      subject.gdpr_consent = nil
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

    it 'validates presence of email' do
      subject.email = nil
      expect(subject).to_not be_valid
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

    it 'validates presence of dc_pot_confirmed' do
      subject.dc_pot_confirmed = nil
      expect(subject).to_not be_valid
    end

    it 'does not permit profanity in the memorable_word' do
      subject.memorable_word = 'twat'
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
