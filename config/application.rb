require_relative './boot'

require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module PensionGuidance
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
  end
end
