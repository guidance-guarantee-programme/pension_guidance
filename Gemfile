ruby IO.read('.ruby-version').strip

# force Bundler to use HTTPS for github repos
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

source 'https://rubygems.org' do # rubocop:disable Metrics/BlockLength
  gem 'autoprefixer-rails'
  gem 'booking_locations'
  gem 'bugsnag'
  gem 'canonical-rails'
  gem 'connection_pool'
  gem 'email_validation'
  gem 'faraday'
  gem 'faraday-conductivity'
  gem 'faraday_middleware'
  gem 'foreman'
  gem 'gaffe'
  gem 'govspeak', '~> 3.2'
  gem 'govuk_elements_rails'
  gem 'govuk_frontend_toolkit'
  gem 'govuk_template'
  gem 'humanize'
  gem 'inline_svg'
  gem 'nokogiri'
  gem 'output-templates', '~> 4.10', github: 'guidance-guarantee-programme/output-templates'
  gem 'pg', '>= 0.18'
  gem 'phoner'
  gem 'postcodes_io'
  gem 'princely'
  gem 'puma'
  gem 'rails', '~> 5.2'
  gem 'redis'
  gem 'rgeo'
  gem 'rgeo-geojson'
  gem 'rubytree'
  gem 'sassc', '1.11.4'
  gem 'sassc-rails', '1.3.0'
  gem 'sprockets', '~> 3'
  gem 'sprockets-es6'
  gem 'sprockets-rails'
  gem 'uglifier', '3.0.4'
  gem 'uk_postcode'
  gem 'utf8-cleaner'
  gem 'zendesk_api'

  group :development, :test do
    gem 'jasmine-jquery-rails'
    gem 'jasmine-rails'
    gem 'pry-byebug'
    gem 'rspec-rails'
    gem 'shoulda-matchers'
  end

  group :development do
    gem 'rubocop', require: false
  end

  group :test do
    gem 'axe-matchers', '2.1.0'
    gem 'cucumber', '3.0.2'
    gem 'cucumber-rails', '1.6.0', require: false
    gem 'database_cleaner'
    gem 'factory_bot_rails'
    gem 'fakeredis'
    gem 'launchy'
    gem 'pdf-inspector', require: 'pdf/inspector'
    gem 'phantomjs'
    gem 'poltergeist'
    gem 'rails-controller-testing'
    gem 'scss-lint', '~> 0.30'
    gem 'site_prism'
    gem 'timecop'
    gem 'vcr'
    gem 'webmock'
    gem 'wraith'
  end

  group :staging, :production do
    gem 'lograge'
    gem 'rails_12factor'
    gem 'redis-rails', require: false
  end
end
