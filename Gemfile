source 'https://rubygems.org'

ruby IO.read('.ruby-version').strip

# force Bundler to use HTTPS for github repos
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem 'autoprefixer-rails'
gem 'bugsnag'
gem 'canonical-rails'
gem 'faraday'
gem 'faraday-conductivity'
gem 'faraday_middleware'
gem 'foreman'
gem 'gaffe'
gem 'govspeak', '~> 3.2'
gem 'govuk_frontend_toolkit'
gem 'govuk_template'
gem 'humanize'
gem 'newrelic_rpm'
gem 'nokogiri'
gem 'output-templates', '~> 4.1.0', github: 'guidance-guarantee-programme/output-templates'
gem 'phoner'
gem 'princely'
gem 'postcodes_io'
gem 'puma'
gem 'rails', '5.0.0.rc1'
gem 'rails-controller-testing'
gem 'redis'
gem 'rgeo'
gem 'rgeo-geojson'
gem 'rubytree'
gem 'sassc-rails'
gem 'sprockets-es6'
gem 'sprockets-rails', '~> 3.0'
gem 'uglifier', '>= 1.3.0'
gem 'uk_postcode'
gem 'utf8-cleaner'

group :development, :test do
  gem 'jasmine-jquery-rails'
  gem 'jasmine-rails'
  gem 'phantomjs', '1.9.8.0'
  gem 'pry-rails'
  gem 'rspec-rails', '3.5.0.beta3'
end

group :development do
  gem 'rubocop', require: false
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'fakeredis'
  gem 'launchy'
  gem 'pdf-inspector', require: 'pdf/inspector'
  gem 'poltergeist'
  gem 'scss-lint', '~> 0.30'
  gem 'shoulda-matchers'
  gem 'site_prism'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end

group :staging, :production do
  gem 'rails_12factor'
end
