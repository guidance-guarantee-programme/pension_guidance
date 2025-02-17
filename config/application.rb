require_relative './boot'

require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'sprockets/es6'

require_relative '../app/repositories/guide_repository'
require_relative '../app/middleware/strip_session_cookie'

Bundler.require(*Rails.groups)

require 'ipaddr'

module PensionGuidance
  TRUSTED_CLOUDFLARE_IPS = %w[
    103.21.244.0/22
    103.22.200.0/22
    103.31.4.0/22
    104.16.0.0/12
    108.162.192.0/18
    131.0.72.0/22
    141.101.64.0/18
    162.158.0.0/15
    172.64.0.0/13
    173.245.48.0/20
    188.114.96.0/20
    190.93.240.0/20
    197.234.240.0/22
    198.41.128.0/17
  ].map { |ip| IPAddr.new(ip) }

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

    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml')]
    config.i18n.available_locales = %i[en cy]

    # Strip cookies to cache guides and localised home pages
    cacheable_paths = GuideRepository.cacheable_paths.push('/en', '/cy')

    config.middleware.insert_before(
      ActionDispatch::Cookies,
      Middleware::StripSessionCookie,
      paths: cacheable_paths
    )

    config.middleware.swap(
      ActionDispatch::RemoteIp,
      ActionDispatch::RemoteIp,
      true,
      TRUSTED_CLOUDFLARE_IPS
    )
  end
end

# New versions of action_dispatch renamed `#success?` to `#successful?`, but
# we can't upgrade jasmine-rails (which calls the former method).
module ActionDispatch
  class TestResponse
    if Rails.env.test?
      def success?
        successful?
      end
    end
  end
end
