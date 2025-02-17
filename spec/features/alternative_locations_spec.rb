require 'spec_helper'
require 'booking_locations/stub_api'

RSpec.feature 'Alternative locations' do
  scenario 'when there are more than three slots available', vcr: true do
    given_a_location_without_limited_availability do
      when_i_try_to_book_an_appointment
      then_i_should_not_see_suggested_alternative_locations
    end
  end

  context 'when there are less than three slots available' do
    scenario 'and nearby alternatives', vcr: true do
      given_a_location_with_limited_availability_and_available_alternatives do
        when_i_try_to_book_an_appointment
        then_i_should_see_suggested_alternative_locations
        and_i_should_not_see_online_booking_disabled_locations
        and_i_should_not_be_suggested_anywhere_more_than_5_miles_away
        and_i_should_not_be_suggested_anywhere_with_less_than_3_slots
      end
    end

    scenario 'but no nearby alternatives', vcr: true do
      given_a_location_with_limited_availability_but_no_available_alternatives do
        when_i_try_to_book_an_appointment
        then_i_should_not_see_suggested_alternative_locations
      end
    end
  end
end

def given_a_location_with_limited_availability_and_available_alternatives(&block) # rubocop:disable Metrics/MethodLength
  with_temporary_environment(block) do
    BookingRequests.api = Class.new do
      def slots(location_id) # rubocop:disable Metrics/MethodLength
        two_days   = 2.days.from_now.to_date.to_fs(:db)
        three_days = 3.days.from_now.to_date.to_fs(:db)

        case location_id
        when 'ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef', 'c165d25e-f27b-4ce9-b3d3-e7415ebaa93c' # Hackney, Haringey
          {
            two_days => ["#{two_days} 09:00:00 UTC", "#{two_days} 13:00:00 UTC"]
          }
        else
          {
            two_days => ["#{two_days} 09:00:00 UTC", "#{two_days} 13:00:00 UTC"],
            three_days => ["#{three_days} 09:00:00 UTC", "#{three_days} 13:00:00 UTC"]
          }
        end
      end
    end.new
  end
end

def given_a_location_with_limited_availability_but_no_available_alternatives(&block) # rubocop:disable Metrics/MethodLength
  with_temporary_environment(block) do
    BookingRequests.api = Class.new do
      def slots(location_id)
        two_days = 2.days.from_now.to_date.to_fs(:db)

        if location_id == 'ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef' # Hackney
          {
            two_days => ["#{two_days} 09:00:00 UTC", "#{two_days} 13:00:00 UTC"]
          }
        else
          {}
        end
      end
    end.new
  end
end

def given_a_location_without_limited_availability(&block) # rubocop:disable Metrics/MethodLength
  with_temporary_environment(block) do
    BookingRequests.api = Class.new do
      def slots(*)
        two_days   = 2.days.from_now.to_date.to_fs(:db)
        three_days = 3.days.from_now.to_date.to_fs(:db)

        {
          two_days => ["#{two_days} 09:00:00 UTC", "#{two_days} 13:00:00 UTC"],
          three_days => ["#{three_days} 09:00:00 UTC", "#{three_days} 13:00:00 UTC"]
        }
      end
    end.new
  end
end

def when_i_try_to_book_an_appointment
  visit('/en/locations/ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef/booking-request/step-one')
end

def then_i_should_see_suggested_alternative_locations
  expect(page).to have_selector('.t-limited-availability')
end

def and_i_should_not_see_online_booking_disabled_locations
  within('.t-limited-availability') do
    expect(page).to have_no_content('Newham')
  end
end

def and_i_should_not_be_suggested_anywhere_more_than_5_miles_away
  within('.t-limited-availability') do
    expect(page).not_to have_content('Enfield')
  end
end

def and_i_should_not_be_suggested_anywhere_with_less_than_3_slots
  within('.t-limited-availability') do
    expect(page).not_to have_content('Haringey')
  end
end

def then_i_should_not_see_suggested_alternative_locations
  expect(page).not_to have_selector('.t-limited-availability')
end

def with_temporary_environment(steps_block) # rubocop:disable Metrics/MethodLength
  previous_geo_json_path_or_url = Locations.geo_json_path_or_url
  previous_locations_api = BookingLocations.api
  previous_requests_api = BookingRequests.api

  Locations.geo_json_path_or_url = Rails.root.join('spec/fixtures/locations_with_alternates.json')
  BookingLocations.api = BookingLocations::StubApi.new

  yield

  steps_block.call
ensure
  Locations.geo_json_path_or_url = previous_geo_json_path_or_url
  BookingLocations.api = previous_locations_api
  BookingRequests.api = previous_requests_api
end
