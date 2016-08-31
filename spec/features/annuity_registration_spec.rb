RSpec.feature 'Register for an annuities appointment' do
  let(:test_api_class) do
    Class.new do
      attr_reader :last_called_with

      def create_ticket(args)
        @last_called_with = args
      end
    end
  end
  let(:test_api) { test_api_class.new }

  around do |ex|
    begin
      real_api = ZenDesk.api
      ZenDesk.api = test_api
      ex.run
    ensure
      ZenDesk.api = real_api
    end
  end

  scenario 'Register for an appointment' do
    when_i_complete_annuities_preregistration
    then_my_details_have_stored_for_future_contact
  end

  def when_i_complete_annuities_preregistration # rubocop:disable Metrics/MethodLength
    visit '/annuity-registration'

    fill_in 'First name', with: 'Rick'
    fill_in 'Last name', with: 'Sanchez'
    fill_in 'Age', with: '101'
    fill_in 'Phone number', with: '07111111111'
    fill_in 'Email', with: 'rick@sanhez.com'
    fill_in 'Postcode', with: 'RS1 1SR'
    choose 'A personal annuity in your own name'
    fill_in 'How much do you get from your annuity each month?', with: '254'
    choose 'Face to face'
    fill_in 'What would you like to get from the appointment?', with: "lots of\nhelp"

    click_on 'Submit'
  end

  def then_my_details_have_stored_for_future_contact
    expect(test_api.last_called_with).to include(
      name: 'Rick Sanchez',
      email: 'rick@sanhez.com',
      subject: 'Annuities Registration',
      tags: ['annuities_registration'],
      custom_fields: {
        id: nil,
        value: 'Rick,Sanchez,07111111111,rick@sanhez.com,RS1 1SR,101,254,face_to_face,in_own_name,lots of help'
      }
    )
  end
end
