require 'securerandom'
require 'booking_locations/stub_api'

RSpec.describe 'DELETE /cache', type: :request do
  scenario 'unauthorised access' do
    when_the_client_makes_an_unauthorised_request
    then_the_service_responds_with_a_401
  end

  scenario 'expiring the locations cache entries' do
    with_stubbed_booking_locations do
      given_various_cache_entries_exist
      when_the_client_makes_the_request
      then_only_the_cached_locations_are_expired
      and_the_service_responds_with_a_204
    end
  end

  def when_the_client_makes_an_unauthorised_request
    ENV['LOCATIONS_CACHE_TOKEN'] = 'welp'
    token = ActionController::HttpAuthentication::Token.encode_credentials('deadbeef')

    delete locations_cache_path, headers: { 'HTTP_AUTHORIZATION' => token }
  end

  def then_the_service_responds_with_a_401
    expect(response).to be_unauthorized
  end

  def given_various_cache_entries_exist
    @location_cache_key = 'ac7112c3-e3cf-45cd-a8ff-9ba827b8e7ef'
    # this will cause a cache miss / write
    BookingLocations.find(@location_cache_key)

    @other_cache_keys = %w(boop snoot).each do |cache_key|
      Rails.cache.write(cache_key, '...')
    end
  end

  def when_the_client_makes_the_request
    ENV['LOCATIONS_CACHE_TOKEN'] = 'deadbeef'
    token = ActionController::HttpAuthentication::Token.encode_credentials('deadbeef')

    delete locations_cache_path, headers: { 'HTTP_AUTHORIZATION' => token }
  end

  def then_only_the_cached_locations_are_expired
    expect(Rails.cache.fetch(@location_cache_key)).to be_nil

    @other_cache_keys.each do |cache_key|
      expect(Rails.cache.fetch(cache_key)).to be_present
    end
  end

  def and_the_service_responds_with_a_204
    expect(response).to be_no_content
  end

  def with_stubbed_booking_locations
    cache = Rails.cache
    api   = BookingLocations.api

    BookingLocations.api = BookingLocations::StubApi.new
    Rails.cache = ActiveSupport::Cache::MemoryStore.new

    yield
  ensure
    BookingLocations.api = api
    Rails.cache = cache
  end
end
