require 'capybara'
require 'selenium/webdriver'
require 'webdrivers/chromedriver'

Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w(headless no-sandbox disable-gpu window-size=2500,2500)
  )

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_normalize_ws = true
Capybara.default_max_wait_time = 10 if ENV['TRAVIS']
Capybara.server = :puma, { Silent: true }
Capybara.javascript_driver = :chrome_headless
