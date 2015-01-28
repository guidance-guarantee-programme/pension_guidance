require_relative './boot'

require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module PensionGuidance
  class Application < Rails::Application
    config.action_dispatch.rescue_responses.merge! 'GuideRepository::GuideNotFound' => :not_found

    config.autoload_paths << Rails.root.join('lib')

    config.middleware.use Rack::Deflater
    config.middleware.use Rack::BounceFavicon
  end
end
