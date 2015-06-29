require 'cucumber/rails'
require 'cucumber/rspec/doubles'

ActionController::Base.allow_rescue = false

Locations.geo_json_path_or_url = Rails.root.join('features', 'fixtures', 'locations.json')
