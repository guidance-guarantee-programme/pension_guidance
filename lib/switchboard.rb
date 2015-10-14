class Switchboard
  class << self
    def lookup(id)
      return unless connection

      response = connection.get("/lookup/#{id}")
      response.body['phone']
    rescue HTTPConnection::ResourceNotFound, HTTPConnection::ClientError
      return
    end

    private

    def connection
      Registry[:switchboard_connection]
    end
  end
end
