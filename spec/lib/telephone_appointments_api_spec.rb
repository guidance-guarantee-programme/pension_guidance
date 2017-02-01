RSpec.describe TelephoneAppointmentsApi do
  context 'with valid params' do
    before do
      allow(HTTPConnectionFactory).to receive(:build).and_return(connection)
      allow(connection).to receive(:headers).and_return(headers)
      allow(connection).to receive(:post)
    end

    subject do
      described_class.new
    end

    let(:connection) do
      double(:connection)
    end

    let(:headers) do
      {}
    end

    let(:telephone_appointment) do
      TelephoneAppointment.new(
        start_at: Time.zone.now.to_s,
        first_name: 'First',
        last_name: 'Last',
        email: 'email@example.org',
        phone: '29309203023',
        memorable_word: 'hello',
        date_of_birth_year: '1920',
        date_of_birth_month: '10',
        date_of_birth_day: '23',
        dc_pot_confirmed: 'yes',
        opt_out_of_market_research: 'true',
        accept_terms_and_conditions: 'true'
      )
    end

    it 'posts the telephone appointment' do
      subject.create(telephone_appointment)

      expect(connection).to have_received(:post).with(
        '/api/v1/appointments',
        telephone_appointment.attributes
      )
    end
  end
end