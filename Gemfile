ruby IO.read('.ruby-version').strip

source 'https://rubygems.org'

# force Bundler to use HTTPS for github repos
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem 'autoprefixer-rails'
gem 'azure-storage-blob'
gem 'base64'
gem 'bigdecimal'
gem 'booking_locations', github: 'guidance-guarantee-programme/booking_locations', ref: 'da91141'
gem 'bugsnag'
gem 'canonical-rails'
gem 'concurrent-ruby', '1.3.4'
gem 'connection_pool'
gem 'country_select'
gem 'csv'
gem 'email_validation'
gem 'faraday'
gem 'faraday-conductivity'
gem 'faraday_middleware'
gem 'faraday-net_http'
gem 'foreman'
gem 'gaffe'
gem 'govspeak', '~> 6.8'
gem 'govuk_elements_rails',
    github: 'guidance-guarantee-programme/govuk_elements_rails',
    branch: 'missing-symlinks',
    submodules: true
gem 'govuk_frontend_toolkit'
gem 'govuk_template'
gem 'humanize'
gem 'inline_svg'
gem 'mutex_m'
gem 'nokogiri'
gem 'observer'
gem 'output-templates', github: 'guidance-guarantee-programme/output-templates', ref: '4e5fe3e'
gem 'pg', '>= 0.18'
gem 'phoner'
gem 'postcodes_io'
gem 'postgres-copy'
gem 'princely'
gem 'profanity_filter', github: 'guidance-guarantee-programme/profanity_filter'
gem 'puma'
gem 'rails', '~> 7.0.1'
gem 'recaptcha'
gem 'redis'
gem 'resolv-replace'
gem 'rgeo'
gem 'rgeo-geojson'
gem 'rubytree'
gem 'sassc-rails'
gem 'sprockets', git: 'https://github.com/rails/sprockets', ref: '3.x'
gem 'sprockets-es6'
gem 'sprockets-rails'
gem 'uglifier', '3.0.4'
gem 'uk_postcode'
gem 'utf8-cleaner'

group :development, :test do
  gem 'jasmine-core', '2.5.2'
  gem 'jasmine-jquery-rails'
  gem 'jasmine-rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'cucumber'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'drb'
  gem 'factory_bot_rails'
  gem 'fakeredis'
  gem 'launchy'
  gem 'pdf-inspector', require: 'pdf/inspector'
  gem 'rails-controller-testing'
  gem 'scss-lint', '~> 0.30'
  gem 'selenium-webdriver'
  gem 'site_prism'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end

group :staging, :production do
  gem 'lograge'
  gem 'rails_12factor'
  gem 'redis-rails', require: false
end
