require 'zendesk_api'

module ZenDesk
  class Client
    def initialize(ticket_class: ZendeskAPI::Ticket, client: nil)
      @ticket_class = ticket_class
      @client = client
    end

    def create_ticket(**options)
      create_ticket!(**options)
    rescue ZendeskAPI::Error::RecordInvalid => e
      Bugsnag.notify(e)
    end

    # rubocop:disable Metrics/ParameterLists
    def create_ticket!(name:, email:, message:, subject:, tags:, custom_fields: nil)
      ticket = {
        subject: subject,
        requester: { name: name, email: email },
        comment: { value: message },
        tags: tags
      }
      ticket[:custom_fields] = custom_fields if custom_fields

      ticket_class.create!(client, ticket)
    end
    # rubocop:enable Metrics/ParameterLists

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
