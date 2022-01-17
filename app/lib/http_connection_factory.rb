require 'faraday'
require 'faraday/conductivity'

module HTTPConnectionFactory
  def self.build(url, timeout: 5, open_timeout: 5, retries: 2)
    connection = Faraday.new(url: url, request: { timeout: timeout, open_timeout: open_timeout }) do |faraday|
      faraday.adapter :net_http
      faraday.request :json
      faraday.request :retry, retries
      faraday.request :user_agent, app: 'PensionWise', version: 1.0

      faraday.response :raise_error
      faraday.response :json

      faraday.use :instrumentation

      faraday.adapter Faraday.default_adapter
    end

    HTTPConnection.new(connection)
  end
end
