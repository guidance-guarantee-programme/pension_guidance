require_relative '../../app/lib/locations'

Locations.geo_json_path_or_url = if Rails.env.test?
                                   Rails.root.join('features/fixtures/locations.json')
                                 else
                                   ENV['LOCATIONS_URL'] || 'https://locator.pensionwise.gov.uk/locations.json'
                                 end
