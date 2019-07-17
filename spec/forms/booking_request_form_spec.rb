RSpec.describe BookingRequestForm do
  let(:location_id) { SecureRandom.uuid }

  describe 'validation' do
    subject do
      described_class.new(
        location_id,
        selected_date: '2150-01-01',
        start_at: '2150-01-01 09:00:00 UTC',
        first_name: 'Lucius',
        last_name: 'Needful',
        email: 'lucius@example.com',
        telephone_number: '0208 244 3987',
        memorable_word: 'meseeks',
        date_of_birth: '2100-01-01',
        accessibility_requirements: '0',
        additional_info: '',
        dc_pot: 'yes',
        remote_ip: '214.142.214.142',
        where_you_heard: '1',
        gdpr_consent: 'yes'
      )
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_step_one_valid
      expect(subject).to be_step_two_valid
      expect(subject).to be_eligible
    end

    context 'step one' do
      it 'requires the first slot' do
        subject.start_at = nil

        expect(subject).to_not be_step_one_valid
      end

      it 'requires the selected date' do
        subject.selected_date = nil

        expect(subject).to_not be_step_one_valid
      end
    end

    context 'step two' do
      %w(first_name last_name email telephone_number memorable_word).each do |field|
        it "requires a #{field}" do
          subject.public_send("#{field}=", '')
          expect(subject).not_to be_step_two_valid
        end
      end

      it 'requires a reasonably valid phone number' do
        ['+447715930459', '(0208) 252 4729', '07715-930-459'].each do |number|
          subject.telephone_number = number
          expect(subject).to be_step_two_valid
        end

        ['ben@example.com', '      ', '02089292992e'].each do |number|
          subject.telephone_number = number
          expect(subject).not_to be_step_two_valid
        end
      end

      it 'requires a reasonably valid email' do
        subject.email = 'blah'
        expect(subject).not_to be_step_two_valid

        subject.email = 'ben@example.com0123456789'
        expect(subject).not_to be_step_two_valid
      end

      it 'requires a valid DOB' do
        subject.date_of_birth = '--01'
        expect(subject).not_to be_step_two_valid
      end

      it 'is invalid if the person in under 50 at time of the primary slot' do
        subject.start_at = '2149-12-31 09:00:00 UTC'

        expect(subject.appointment_type).to eq('under-50')
        expect(subject).not_to be_eligible
      end

      it 'is valid if the person is exactly 50 at time of the primary slot' do
        subject.date_of_birth = '2100-01-01'

        expect(subject.appointment_type).to eq('50-54')
        expect(subject).to be_eligible
      end

      it 'is valid if the person is exactly 55 at time of the primary slot' do
        subject.date_of_birth = '2095-01-01'

        expect(subject.appointment_type).to eq('55-plus')
        expect(subject).to be_eligible
      end

      it 'requires accessibility_requirements to be true or false' do
        subject.accessibility_requirements = nil
        expect(subject).not_to be_step_two_valid
      end

      it 'requires dc_pot is accepted' do
        subject.dc_pot = false
        expect(subject).not_to be_step_two_valid
        expect(subject).not_to be_eligible
      end

      it 'ensures `additional_info` is no longer than 160 characters' do
        subject.additional_info = '*' * 161
        expect(subject).not_to be_step_two_valid
      end

      it 'requires the `where_you_heard`' do
        subject.where_you_heard = ''
        expect(subject).not_to be_step_two_valid
      end
    end
  end

  context 'appointment_type' do
    subject do
      described_class.new(location_id, start_at: '2150-01-01 09:00:00 UTC')
    end

    it 'converts date of birth into an age range' do
      subject.date_of_birth = '2100-01-01'
      expect(subject.appointment_type).to eq '50-54'
    end

    it 'is under 50 if no date of birth set' do
      expect(subject.appointment_type).to eq 'under-50'
    end
  end
end
