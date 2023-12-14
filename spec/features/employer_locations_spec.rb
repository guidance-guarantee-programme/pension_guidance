# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
require_relative '../../features/pages/employer_location'
require_relative '../../features/pages/employer_locations'

RSpec.feature 'Employer locations' do
  scenario 'Viewing available locations' do
    given_bookable_tesco_locations_exist do
      when_the_customer_visits_the_tesco_locations_page
      then_they_see_the_locations
      when_they_click_on_the_location
      then_they_see_the_full_location_details
    end
  end

  def given_bookable_tesco_locations_exist
    previous = Employer.api

    Employer.api = Class.new do
      def employer(*)
        {
          'name' => 'Tesco',
          'locations' => [
            {
              'id' => 123,
              'name' => 'Tesco Headquarters',
              'address_line_one' => 'Tesco House',
              'address_line_two' => 'Shire Park',
              'address_line_three' => 'Kestrel Way',
              'county' => 'Welwyn Garden City',
              'postcode' => 'AL7 1GA',
              'available' => true
            }
          ]
        }
      end

      def location(*)
        employer['locations'].first
      end
    end.new

    yield
  ensure
    Employer.api = previous
  end

  def when_the_customer_visits_the_tesco_locations_page
    @page = Pages::EmployerLocations.new
    @page.load(employer_id: 1)
  end

  def then_they_see_the_locations
    expect(@page).to have_locations(count: 1)
    expect(@page.locations.first).to have_text('Tesco Headquarters')
  end

  def when_they_click_on_the_location
    @page.locations.first.click
  end

  def then_they_see_the_full_location_details
    @page = Pages::EmployerLocation.new
    expect(@page).to be_displayed
    expect(@page.name).to have_text('Tesco Headquarters')
    expect(@page.address).to have_text('Tesco House')
    expect(@page).to have_book_online
  end
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize
