source 'https://rubygems.org'

ruby '2.1.4'

gem 'foreman'
gem 'govuk_frontend_toolkit'
gem 'govuk_template'
gem 'govspeak', '~> 3.2'
gem 'rails', '4.1.8'
gem 'sass-rails', '~> 4.0'
gem 'sprockets', '~> 2.11.0' # 2.12.x breaks sass-rails
gem 'uglifier', '>= 1.3.0'
gem 'unicorn'

group :development do
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'rspec-rails', '~> 3.0.0'
  gem 'site_prism'
  gem 'scss-lint', '~> 0.30'
end

group :production do
  gem 'rails_12factor'
end
