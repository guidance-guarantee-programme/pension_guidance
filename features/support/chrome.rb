require 'capybara'
require 'selenium/webdriver'
require 'webdrivers/chromedriver'

# Pinned for this https://github.com/titusfortner/webdrivers/issues/237
Webdrivers::Chromedriver.required_version = '106.0.5249.21'

Capybara.register_driver :chrome_headless do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--window-size=2500,2500'
    opts.args << '--force-device-scale-factor=0.95'
    opts.args << '--headless'
    opts.args << '--disable-gpu'
    opts.args << '--disable-site-isolation-trials'
    opts.args << '--no-sandbox'
  end

  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: browser_options)
end

Capybara.default_max_wait_time = 10 if ENV['TRAVIS']
Capybara.server = :puma, { Silent: true }
Capybara.javascript_driver = :chrome_headless
