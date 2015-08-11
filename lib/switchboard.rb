class Switchboard
  class << self
    def lookup(id)
      return unless base_url

      response = Excon.new("#{base_url}/lookup/#{id}").get
      return unless response.status == 200

      begin
        json = JSON.parse(response.body)
      rescue JSON::ParserError
        return
      end

      json['phone']
    end

    private

    def base_url
      ENV['SWITCHBOARD_BASE_URL']
    end
  end
end
