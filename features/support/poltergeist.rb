require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, url_whitelist: %w(127.0.0.1))
end

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 20
