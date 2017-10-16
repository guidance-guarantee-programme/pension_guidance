# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
require_relative '../../features/pages/tesco_locations'

RSpec.feature 'Tesco locations' do
  scenario 'Viewing available locations' do
    given_bookable_tesco_locations_exist do
      when_the_customer_visits_the_tesco_locations_page
      then_they_see_the_locations
    end
  end

  def given_bookable_tesco_locations_exist
    Tesco.api = Class.new do
      def locations
        [
          {
            'id' => 123,
            'name' => 'Tesco Headquarters',
            'address_line_one' => 'Tesco House',
            'address_line_two' => 'Shire Park',
            'address_line_three' => 'Kestrel Way',
            'county' => 'Welwyn Garden City',
            'postcode' => 'AL7 1GA'
          }
        ]
      end
    end.new

    yield
  end

  def when_the_customer_visits_the_tesco_locations_page
    @page = Pages::TescoLocations.new.tap(&:load)
  end

  def then_they_see_the_locations
    expect(@page).to have_locations(count: 1)

    @page.locations.first.tap do |hq|
      expect(hq.name).to have_text('Tesco Headquarters')
      expect(hq.address).to have_text('Tesco House')

      expect(hq).to have_book_online
    end
  end
end
