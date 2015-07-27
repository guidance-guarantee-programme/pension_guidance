RSpec.describe Appointment, type: :model do
  it { should validate_presence_of(:slot) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:email) }
  it { should validate_inclusion_of(:type).in_array(Appointment::TYPES) }

  it { should allow_value('2015-07-13T12:32:18+01:00').for(:slot) }
  it { should_not allow_value('xxx').for(:slot) }

  describe '#slot=' do
    let(:timestamp) { Time.zone.now.to_s }

    subject(:appointment) { Appointment.new }

    before { appointment.slot = timestamp }

    it 'makes the slot a DateTime object' do
      expect(appointment.slot).to be_a(DateTime)
    end
  end

  describe '#full_name' do
    subject(:appointment) { Appointment.new(name: 'Elvis', surname: 'Presley') }

    it 'returns name and surname' do
      expect(appointment.full_name).to eq 'Elvis Presley'
    end
  end

  describe '#save' do
    let(:appointment) { described_class.new }
    let(:appointment_ticket) { double }
    let(:valid) { true }

    subject { appointment.save }

    before do
      allow(appointment).to receive(:valid?).and_return(valid)
      allow(AppointmentTicket).to receive(:new).and_return(appointment_ticket)
    end

    context 'valid appointment' do
      before do
        expect(appointment_ticket).to receive(:create!)
      end

      it { is_expected.to eq(valid) }
    end

    context 'invalid appointment' do
      let(:valid) { false }

      before do
        expect(appointment_ticket).to_not receive(:create!)
      end

      it { is_expected.to eq(valid) }
    end
  end

  describe 'type' do
    context 'phone appointment' do
      before do
        allow(subject).to receive(:type).and_return('phone')
      end

      it { should validate_presence_of(:memorable_word) }
    end

    context 'face-to-face appointment' do
      before do
        allow(subject).to receive(:type).and_return('face-to-face')
      end

      it { should validate_presence_of(:postcode) }
    end
  end
end
