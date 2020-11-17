require_relative '../../features/pages/location_page'

RSpec.feature 'Identifying as a TP agent' do
  before do
    @previous_locations   = Locations.geo_json_path_or_url
    @previous_booking_api = BookingRequests.api
  end

  after do
    Locations.geo_json_path_or_url = @previous_locations
    BookingRequests.api = @previous_booking_api
  end

  scenario 'Viewing locations as an agent' do
    given_the_user_is_an_agent do
      and_locations_exist_for_online_booking
      and_the_locations_are_available
      when_they_view_a_location
      then_they_see_the_specialised_start_button
    end
  end

  def given_the_user_is_an_agent
    ENV['TP_IP_ADDRESSES'] = '127.0.0.1'
    yield
  ensure
    ENV.delete('TP_IP_ADDRESSES')
  end

  def and_locations_exist_for_online_booking
    Locations.geo_json_path_or_url = Rails.root.join(
      'features',
      'fixtures',
      'locations_with_online_booking.json'
    )
  end

  def and_the_locations_are_available
    BookingRequests.api = Class.new do
      def slots(*)
        two_days = 2.days.from_now.to_date.iso8601

        {
          two_days => ["#{two_days} 09:00:00 UTC", "#{two_days} 13:00:00 UTC"]
        }
      end
    end.new
  end

  def when_they_view_a_location
    @page = Pages::Location.new
    @page.load(locale: 'en', id: 'ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef')
  end

  def then_they_see_the_specialised_start_button
    expect(@page).to have_agent_book_online
  end
end
