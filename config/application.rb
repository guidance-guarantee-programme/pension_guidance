require_relative './boot'

require 'active_model/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'sprockets/es6'

Bundler.require(*Rails.groups)

module PensionGuidance
  class Application < Rails::Application
    config.action_controller.include_all_helpers = false
    config.action_dispatch.rescue_responses.merge! 'CategoryRepository::CategoryNotFound' => :not_found,
                                                   'GuideRepository::GuideNotFound' => :not_found

    config.autoload_paths << Rails.root.join('lib')

    config.cache_max_age = ENV['CACHE_MAX_AGE'] || 10.seconds

    config.mount_javascript_test_routes = false

    config.action_view.field_error_proc = proc { |html_tag, _|
      html_tag
    }
  end
end
