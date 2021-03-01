require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    phantomjs: Phantomjs.path,
    url_whitelist: %w(127.0.0.1 localhost https://cc.cdn.civiccomputing.com/9/cookieControl-9.x.min.js),
    timeout: ENV.fetch('PHANTOM_JS_TIMEOUT') { 60 },
    phantomjs_options: ['--ignore-ssl-errors=yes', '--ssl-protocol=any']
  )
end

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 20
