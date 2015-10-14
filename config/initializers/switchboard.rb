Registry[:switchboard_connection] =
  if ENV['SWITCHBOARD_BASE_URL']
    HTTPConnectionFactory.build(ENV['SWITCHBOARD_BASE_URL'])
  end
