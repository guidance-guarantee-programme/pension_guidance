RSpec.describe Bsl::BookingRequest do
  let(:attributes) do
    {
      'first_name' => 'Bob',
      'last_name' => 'Smith',
      'email' => 'bob@example.com',
      'phone' => '0208 252 4777',
      'memorable_word' => 'bongo',
      'accessibility_needs' => '0',
      'defined_contribution_pot_confirmed' => 'yes',
      'date_of_birth' => '1950-01-01',
      'additional_info' => '',
      'where_you_heard' => '1',
      'supported' => 'no'
    }
  end

  subject { described_class.new(attributes) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'checks for age eligibility' do
    subject.date_of_birth = '2010-01-01'
    expect(subject).to be_invalid

    subject.date_of_birth = ''
    expect(subject).to be_invalid
  end

  context 'when supported' do
    let(:supported_attributes) do
      {
        'supported' => 'yes',
        'support_name' => 'Dave Jones',
        'support_relationship' => 'Friend',
        'support_email' => 'dave@example.com',
        'support_phone' => '07715 999 345'
      }
    end

    subject { described_class.new(attributes.merge(supported_attributes)) }

    it 'requires the supporter name' do
      subject.support_name = nil

      expect(subject).to be_invalid
    end

    it 'requires the supporter relationship' do
      subject.support_relationship = nil

      expect(subject).to be_invalid
    end

    it 'requires the supporter email' do
      subject.support_email = nil

      expect(subject).to be_invalid
    end

    it 'requires the supporter phone' do
      subject.support_phone = nil

      expect(subject).to be_invalid
    end
  end
end
