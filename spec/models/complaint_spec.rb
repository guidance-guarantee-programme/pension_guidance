RSpec.describe Complaint do
  it 'defaults a missing requester email' do
    complaint = described_class.new(email_address: '')
    expect(complaint.requester_email).to be_present
  end
end
