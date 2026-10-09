describe FaceToFace::Api do
  describe '#create_booking' do
    context 'with valid params' do
      before do
        allow(HTTPConnectionFactory).to receive(:build).and_return(connection)
        allow(connection).to receive(:headers).and_return({})
        allow(connection).to receive(:post).with(
          '/api/v1/face_to_face_bookings',
          booking.payload
        ).and_return(response)
      end

      let(:connection) { double(:connection) }
      let(:booking) do
        FaceToFace::Booking.new(
          first_name: 'Daisy',
          last_name: 'Lowell',
          email: 'daisy@example.com',
          phone: '02082524729',
          memorable_word: 'cheese',
          date_of_birth: '1970-01-01',
          defined_contribution_pot_confirmed: true,
          accessibility_requirements: true,
          adjustments: 'The adjustments',
          additional_info: 'The info',
          where_you_heard: '1',
          gdpr_consent: true,
          supported: false
        )
      end
      let(:response) { double(success?: true) }

      it 'posts the booking' do
        expect(subject.create_booking(booking.payload)).to be_truthy
      end
    end
  end
end
