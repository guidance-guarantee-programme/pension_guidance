RSpec.describe Complaint do
  it 'defaults a missing requester email' do
    complaint = described_class.new(email_address: '')
    expect(complaint.requester_email).to be_present
  end

  describe 'validation' do
    subject { described_class.new(name: 'Karen') }

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
