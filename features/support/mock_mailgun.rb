require 'webrick'

Before('@mock_mailgun') do
  @mailgun_server = WEBrick::HTTPServer.new(
    Port: 9293,
    StartCallback: -> { @mailgun_server_running = true },
    Logger: Rails.logger,
    AccessLog: Rails.logger
  )

  @mailgun_thread = Thread.new { @mailgun_server.start }
  Timeout.timeout(1) { :wait until @mailgun_server_running }
end

After('@mock_mailgun') do
  @mailgun_thread.kill while system('lsof -t -i:9293 > /dev/null')
end

def with_mock_mailgun_response(response)
  @mailgun_server.mount '/v2/address/validate', Rack::Handler::WEBrick, lambda { |env|
    req = Rack::Request.new(env)
    response_body = "#{req.params['callback']}(#{response.to_json})"

    [200, {}, [response_body]]
  }
end
