require_relative './boot'

require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module PensionGuidance
  class Application < Rails::Application
    config.action_dispatch.rescue_responses.merge! 'GuideRepository::GuideNotFound' => :not_found
    config.action_view.field_error_proc = proc { |html_tag, _| html_tag.html_safe }

    config.autoload_paths << Rails.root.join('lib')

    config.cache_max_age = ENV['CACHE_MAX_AGE'] || 10.seconds

    config.middleware.use Rack::BounceFavicon

    config.mount_javascript_test_routes = false
  end
end
