require_relative './boot'

require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module PensionGuidance
  class Application < Rails::Application
    config.action_controller.include_all_helpers = false
    config.action_dispatch.rescue_responses.merge! 'CategoryRepository::CategoryNotFound' => :not_found,
                                                   'GuideRepository::GuideNotFound' => :not_found

    config.autoload_paths << Rails.root.join('lib')

    config.cache_max_age = ENV['CACHE_MAX_AGE'] || 10.seconds

    config.middleware.use Rack::BounceFavicon
    require 'bounce_browserconfig'
    config.middleware.use BounceBrowserconfig

    config.mount_javascript_test_routes = false
  end
end
