RSpec.describe TelephoneAppointmentsApi do
  describe '#slots' do
    before do
      allow(HTTPConnectionFactory).to receive(:build).and_return(connection)
      allow(connection).to receive(:headers).and_return({})
      allow(connection).to receive(:get).and_return(double(body: {}))
    end

    let(:connection) do
      double(:connection)
    end

    let(:headers) do
      {}
    end

    context 'for Lloyds' do
      it 'uses the filtered path for slots' do
        subject.slots(true)

        expect(connection).to have_received(:get).with('/api/v1/bookable_slots?schedule_type=pension_wise&lloyds=true')
      end
    end

    context 'for other types of schedule' do
      it 'uses the correct schedule type' do
        subject.slots(false, 'due_diligence')

        expect(connection).to have_received(:get).with('/api/v1/bookable_slots?schedule_type=due_diligence')
      end
    end

    context 'for general availability' do
      it 'uses the unfiltered path for slots' do
        subject.slots

        expect(connection).to have_received(:get).with('/api/v1/bookable_slots?schedule_type=pension_wise')
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      before do
        allow(HTTPConnectionFactory).to receive(:build).and_return(connection)
        allow(connection).to receive(:headers).and_return(headers)
        allow(connection).to receive(:post)
      end

      let(:connection) do
        double(:connection)
      end

      let(:headers) do
        {}
      end

      let(:api_response) do
        double(headers: { 'Location' => '/appointments/123456' })
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
          gdpr_consent: 'yes',
          smarter_signposted: 'true',
          lloyds_signposted: 'false',
          attended_digital: 'true'
        )
      end

      it 'posts the telephone appointment' do
        expect(connection).to receive(:post).with(
          '/api/v1/appointments',
          telephone_appointment.attributes
        ).and_return(api_response)

        expect(subject.create(telephone_appointment)).to be_truthy

        expect(telephone_appointment.id).to eq('123456')
      end
    end
  end
end
