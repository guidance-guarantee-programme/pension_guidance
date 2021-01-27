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
end
