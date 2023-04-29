REDIS_POOL = ConnectionPool.new(
  size:    ENV.fetch('REDIS_POOL_SIZE') { 10 }.to_i,
  timeout: ENV.fetch('REDIS_POOL_TIMEOUT') { 5 }.to_i
) { Redis.new(ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }) }
