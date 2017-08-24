require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    phantomjs: Phantomjs.path,
    url_whitelist: %w(127.0.0.1 localhost),
    timeout: ENV.fetch('PHANTOM_JS_TIMEOUT') { 60 }
  )
end

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 20
