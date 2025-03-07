RSpec.describe WelshLanguage::BookingRequest do
  let(:attributes) do
    {
      'first_name' => 'Bob',
      'last_name' => 'Smith',
      'email' => 'bob@example.com',
      'phone' => '0208 252 4777',
      'memorable_word' => 'bongo',
      'accessibility_needs' => 'false',
      'defined_contribution_pot_confirmed' => 'yes',
      'date_of_birth' => '1950-01-01',
      'additional_info' => '',
      'where_you_heard' => '1'
    }
  end

  subject { described_class.new(attributes) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'when accessibility needs were specified' do
    it 'requires adjustments' do
      subject.accessibility_needs = true
      expect(subject).to be_invalid

      subject.adjustments = 'I need some help with access.'
      expect(subject).to be_valid
    end
  end

  it 'checks for age eligibility' do
    subject.date_of_birth = '2010-01-01'
    expect(subject).to be_invalid

    subject.date_of_birth = ''
    expect(subject).to be_invalid
  end

  it 'requires a location for face-to-face' do
    skip 'COVID-19'

    subject.location_id = nil

    expect(subject).to be_face_to_face
    expect(subject).to be_invalid
  end

  it 'does not require a location for phone bookings' do
    skip 'COVID-19'

    subject.booking_type = 'phone'
    subject.location_id  = nil

    expect(subject).not_to be_face_to_face
    expect(subject).to be_valid
  end
end
