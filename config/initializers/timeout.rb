rack_timeout_in_seconds = Integer(ENV['RACK_TIMEOUT_SECONDS']) rescue 20
Rack::Timeout.timeout = rack_timeout_in_seconds
