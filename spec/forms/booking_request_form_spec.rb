RSpec.describe BookingRequestForm do
  describe 'validation' do
    let(:location_id) { SecureRandom.uuid }

    subject do
      described_class.new(
        location_id,
        primary_slot: '2016-01-01-0900-1300',
        first_name: 'Lucius',
        last_name: 'Needful',
        email: 'lucius@example.com',
        telephone_number: '0208 244 3987',
        memorable_word: 'meseeks',
        date_of_birth: '1950-01-01',
        accessibility_requirements: '0',
        dc_pot: 'yes',
        additional_info: ''
      )
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_step_one_valid
      expect(subject).to be_step_two_valid
      expect(subject).to be_eligible
    end

    context 'step one' do
      it 'requires the first slot' do
        subject.primary_slot = nil

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

      it 'requires appointment_type to be within permitted values' do
        subject.date_of_birth = '2010-01-01'

        expect(subject.appointment_type).to eq('under-50')
        expect(subject).not_to be_eligible
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
    end
  end
end
