RSpec.describe WelshLanguage::Mapper, '#call' do
  subject { described_class.new(booking_request).call }

  context 'when face-to-face' do
    let(:booking_request) { double(location_id: 1, face_to_face?: true).as_null_object }

    it 'includes the `location_id`' do
      expect(subject).to include(location_id: 1)
    end
  end

  context 'when phone' do
    let(:booking_request) { double(location_id: 1, face_to_face?: false).as_null_object }

    it 'does not include the `location_id`' do
      expect(subject).not_to include(location_id: 1)
    end
  end
end
