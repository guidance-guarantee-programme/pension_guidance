source 'https://rubygems.org'

ruby '2.2.2'

gem 'bugsnag'
gem 'canonical-rails'
gem 'draper', '~> 1.3'
gem 'excon'
gem 'foreman'
gem 'gaffe'
gem 'govspeak', '~> 3.2'
gem 'govuk_frontend_toolkit'
gem 'govuk_template'
gem 'newrelic_rpm'
gem 'nokogiri'
gem 'phoner'
gem 'postcodes_io'
gem 'puma'
gem 'rack-contrib'
gem 'rails', '4.2.2'
gem 'redis'
gem 'rgeo'
gem 'rgeo-geojson'
gem 'rubytree'
gem 'sass-rails', '~> 5.0'
gem 'sprockets', '~> 2.12'
gem 'uglifier', '>= 1.3.0'
gem 'uk_postcode'
gem 'utf8-cleaner'

group :development, :test do
  gem 'jasmine-jquery-rails'
  gem 'jasmine-rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.0'
end

group :development do
  gem 'rubocop', require: false
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'fakeredis'
  gem 'launchy'
  gem 'scss-lint', '~> 0.30'
  gem 'site_prism'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end

group :staging, :production do
  gem 'rails_12factor'
end
