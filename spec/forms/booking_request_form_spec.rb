RSpec.describe BookingRequestForm do
  describe 'validation' do
    let(:location_id) { SecureRandom.uuid }

    subject do
      described_class.new(
        location_id,
        primary_slot: '2016-01-01-0900-1300',
        secondary_slot: '2016-01-01-1300-1700',
        tertiary_slot: '2016-01-02-0900-1300',
        first_name: 'Lucius',
        last_name: 'Needful',
        email: 'lucius@example.com',
        telephone_number: '0208 244 3987',
        memorable_word: 'meseeks',
        appointment_type: '55-plus',
        accessibility_requirements: '0',
        opt_in: '0',
        dc_pot: '1'
      )
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_step_one_valid
      expect(subject).to be_step_two_valid
    end

    context 'step one' do
      %w(primary secondary tertiary).each do |slot|
        it "requires the #{slot} slot" do
          subject.public_send("#{slot}_slot=", nil)

          expect(subject).to_not be_step_one_valid
        end
      end
    end

    context 'step two' do
      %w(first_name last_name email telephone_number memorable_word).each do |field|
        it "requires a #{field}" do
          subject.public_send("#{field}=", '')
          expect(subject).not_to be_step_two_valid
        end
      end

      it 'requires a reasonably valid email' do
        subject.email = 'blah'
        expect(subject).not_to be_step_two_valid
      end

      it 'requires appointment_type to be within permitted values' do
        subject.appointment_type = 'under-50'
        expect(subject).not_to be_step_two_valid
      end

      it 'requires accessibility_requirements to be true or false' do
        subject.accessibility_requirements = nil
        expect(subject).not_to be_step_two_valid
      end

      it 'requires opt_in to be true or false' do
        subject.opt_in = nil
        expect(subject).not_to be_step_two_valid
      end

      it 'requires dc_pot is accepted' do
        subject.dc_pot = false
        expect(subject).not_to be_step_two_valid
      end
    end
  end
end
