RSpec.describe Complaint do
  describe 'validation' do
    subject { described_class.new(name: 'Karen', email_address: 'karen@example.com') }

    Complaint::NATURE_OF_COMPLAINT.each do |complaint|
      context "when complaint is #{complaint}" do
        it "requires the `#{complaint}`" do
          subject.nature_of_complaint = complaint

          expect(subject).to be_invalid

          subject.public_send(:"#{complaint}=", 'Blah blah')

          expect(subject).to be_valid
        end
      end
    end
  end

  describe '#send_to_zendesk regression around kwargs' do
    it 'ought to accept kwargs properly' do
      ZenDesk.api = ZenDesk::Client.new

      complaint = Complaint.new(
        name: 'Karen',
        email_address: 'karen@example.com',
        nature_of_complaint: 'other_message',
        other_message: 'Blah blah'
      )

      expect { complaint.send_to_zendesk }.not_to raise_error(ArgumentError)
    ensure
      ZenDesk.api = ZenDesk::StubClient.new
    end
  end
end
