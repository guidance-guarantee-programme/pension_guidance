require_relative './production'

Rails.application.configure do
  config.action_dispatch.default_headers = { 'X-Frame-Options' => 'ALLOWALL' }
end
