RSpec.describe FeedbackForm do
  subject do
    described_class.new(
      name: 'Dave Smith',
      email: 'dave@example.com',
      message: 'This is great!',
      feedback_type: 'online_booking'
    )
  end

  describe 'validation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'requires a valid email' do
      subject.email = 'dave@talk talk.net'

      expect(subject).to be_invalid
    end

    it 'permits the phone booking feedback type' do
      subject.feedback_type = 'phone_booking'

      expect(subject).to be_valid
    end
  end
end
