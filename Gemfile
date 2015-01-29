source 'https://rubygems.org'

ruby '2.2.0'

gem 'bugsnag'
gem 'foreman'
gem 'gaffe'
gem 'govspeak', '~> 3.2'
gem 'govuk_frontend_toolkit'
gem 'govuk_template'
gem 'newrelic_rpm'
gem 'puma'
gem 'rack-contrib'
gem 'rails', '4.2.0'
gem 'rack-timeout'
gem 'sass-rails', '~> 4.0'
gem 'sprockets', '~> 2.11.0' # 2.12.x breaks sass-rails
gem 'uglifier', '>= 1.3.0'
gem 'utf8-cleaner'

group :development do
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'rspec-rails', '~> 3.0'
  gem 'site_prism'
  gem 'scss-lint', '~> 0.30'
end

group :production do
  gem 'rails_12factor'
end
