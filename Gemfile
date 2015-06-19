source 'https://rubygems.org'

ruby '2.2.2'

gem 'bugsnag'
gem 'canonical-rails'
gem 'draper', '~> 1.3'
gem 'foreman'
gem 'gaffe'
gem 'govspeak', '~> 3.2'
gem 'govuk_frontend_toolkit'
gem 'govuk_template'
gem 'newrelic_rpm'
gem 'nokogiri'
gem 'postcodes_io'
gem 'puma'
gem 'rack-contrib'
gem 'rails', '4.2.2'
gem 'rgeo'
gem 'rgeo-geojson'
gem 'rubytree'
gem 'sass-rails', '~> 4.0'
gem 'sprockets', '~> 2.11.0' # 2.12.x breaks sass-rails
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
  gem 'spring'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'site_prism'
  gem 'scss-lint', '~> 0.30'
  gem 'vcr'
  gem 'webmock'
end

group :staging, :production do
  gem 'rails_12factor'
end
