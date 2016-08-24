RSpec.describe ZenDesk::Client do
  let(:ticket_class) { double }
  let(:client) { double.as_null_object }

  subject { described_class.new(ticket_class: ticket_class, client: client) }

  it 'delegates creation to the provided ticket class' do
    expect(ticket_class).to receive(:create!).with(
      client,
      hash_including(
        requester: { name: 'Ben', email: 'ben@example.com' },
        comment: { value: 'Awesome!' },
        tags: %w(online_booking)
      )
    )

    subject.create_ticket(name: 'Ben', email: 'ben@example.com', message: 'Awesome!')
  end
end
