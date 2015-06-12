require 'cucumber/rails'
require 'cucumber/rspec/doubles'

ActionController::Base.allow_rescue = false

Locations.path = Rails.root.join('features', 'fixtures', 'locations.json')
