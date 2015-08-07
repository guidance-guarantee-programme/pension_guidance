module Search
  class GoogleCustomSearchEngine
    RequestError = Class.new(StandardError) do
      attr_accessor :original
      private :original=

      def initialize(message, original = $ERROR_INFO)
        super(message)

        self.original = original
      end
    end

    attr_accessor :page, :per_page

    def initialize(key, cx)
      self.connection = Registry[:google_api_connection]
      self.cx = cx
      self.key = key
    end

    def perform(query, page, per_page)
      start_index = ((page * per_page) - (per_page - 1))
      response = connection.get('customsearch/v1',
                                cx: cx,
                                key: key,
                                num: per_page,
                                q: query,
                                start: start_index)

      ResponseMapper.new(response).mapped_response

    rescue HTTPConnection::ConnectionFailed, HTTPConnection::ClientError
      raise RequestError, 'Unable to fetch Search Results from Google Custom Search'
    end

    private

    attr_accessor :connection, :cx, :key
  end
end
