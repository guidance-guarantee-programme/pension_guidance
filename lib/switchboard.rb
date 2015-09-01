class Switchboard
  class << self
    def lookup(id)
      return unless base_url

      response = connection.get("/lookup/#{id}")
      response.body['phone']
    rescue HTTPConnection::ResourceNotFound, HTTPConnection::ClientError
      return
    end

    private

    def base_url
      ENV['SWITCHBOARD_BASE_URL']
    end

    def connection
      HTTPConnectionFactory.build(base_url)
    end
  end
end
