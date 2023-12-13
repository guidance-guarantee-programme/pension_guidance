require 'faraday'

class HTTPConnection < SimpleDelegator
  Error = Class.new(StandardError) do
    attr_reader :original

    def initialize(original = $ERROR_INFO)
      super
      @original = original
    end
  end

  ClientError = Class.new(Error)
  ConnectionFailed = Class.new(Error)
  ResourceNotFound = Class.new(Error)
  UnprocessableEntity = Class.new(Error)

  def get(*args)
    __getobj__.get(*args)
  rescue Faraday::ResourceNotFound
    raise ResourceNotFound
  rescue Faraday::ConnectionFailed
    raise ConnectionFailed
  rescue Faraday::ClientError
    raise ClientError
  end

  def post(*args)
    __getobj__.post(*args)
  rescue Faraday::ConnectionFailed
    raise ConnectionFailed
  rescue Faraday::ClientError => error
    case error.response[:status]
    when 422
      raise UnprocessableEntity
    else
      raise ClientError
    end
  end
end
