ruby IO.read('.ruby-version').strip

# force Bundler to use HTTPS for github repos
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

source 'https://rails-assets.org' do
  gem 'rails-assets-mailgun-validator-jquery', '0.0.3'
end

source 'https://rubygems.org' do # rubocop:disable Metrics/BlockLength
  gem 'autoprefixer-rails'
  gem 'booking_locations'
  gem 'bugsnag'
  gem 'canonical-rails'
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
  gem 'newrelic_rpm'
  gem 'nokogiri'
  gem 'output-templates', '~> 4.6.0', github: 'guidance-guarantee-programme/output-templates'
  gem 'phoner'
  gem 'postcodes_io'
  # https://github.com/mbleigh/princely/pull/53
  gem 'princely', github: 'guidance-guarantee-programme/princely', branch: 'remove-alias-method-chain'
  gem 'puma'
  gem 'rails', '~> 5.1.1'
  gem 'redis'
  gem 'rgeo'
  gem 'rgeo-geojson'
  gem 'rubytree', github: 'guidance-guarantee-programme/rubytree', branch: '24fix'
  gem 'sassc-rails'
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
    gem 'axe-matchers'
    gem 'cucumber-rails', require: false
    gem 'fakeredis'
    gem 'launchy'
    gem 'pdf-inspector', require: 'pdf/inspector'
    gem 'phantomjs-binaries'
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
