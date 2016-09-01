RSpec.describe ZenDesk::Client do
  let(:ticket_class) { double }
  let(:client) { double }

  subject { described_class.new(ticket_class: ticket_class, client: client) }

  it 'delegates creation to the provided ticket class' do
    expect(ticket_class).to receive(:create!).with(
      client,
      hash_including(
        requester: { name: 'Ben', email: 'ben@example.com' },
        comment: { value: 'Awesome!' },
        tags: %w(online_booking),
        subject: 'Online booking test'
      )
    )

    subject.create_ticket(
      name: 'Ben',
      email: 'ben@example.com',
      message: 'Awesome!',
      subject: 'Online booking test',
      tags: %w(online_booking)
    )
  end

  context 'when a ZendeskAPI::Error::ClientError error happens' do
    before do
      allow(ticket_class).to receive(:create!).and_raise(ZendeskAPI::Error::RecordInvalid, {})
    end

    it 'reports the error to BugSnag' do
      expect(Bugsnag).to receive(:notify)
      subject.create_ticket(
        name: 'Ben',
        email: 'ben@example.com',
        message: 'Awesome!',
        subject: 'Online booking test',
        tags: %w(online_booking)
      )
    end

    it 'does not raise an error' do
      expect do
        subject.create_ticket(
          name: 'Ben',
          email: 'ben@example.com',
          message: 'Awesome!',
          subject: 'Online booking test',
          tags: %w(online_booking)
        )
      end.not_to raise_error
    end
  end
end
