require 'zendesk_api'

module ZenDesk
  class Client
    def initialize(ticket_class: ZendeskAPI::Ticket, client: nil)
      @ticket_class = ticket_class
      @client = client
    end

    def create_ticket(name:, email:, message:, subject:, tags:)
      ticket_class.create!(
        client,
        subject: subject,
        requester: { name: name, email: email },
        comment: { value: message },
        tags: tags
      )
    end

    private

    attr_reader :ticket_class

    def client
      @client ||= ZendeskAPI::Client.new do |config|
        config.url      = ENV['ZENDESK_API_URI']
        config.username = ENV['ZENDESK_API_USERNAME']
        config.token    = ENV['ZENDESK_API_TOKEN']
      end
    end
  end
end
