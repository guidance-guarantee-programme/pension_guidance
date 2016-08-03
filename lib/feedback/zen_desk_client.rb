require 'zendesk_api'

module Feedback
  class ZenDeskClient
    def create_ticket(message)
      ZendeskAPI::Ticket.create!(
        client,
        subject: 'Online Booking feedback',
        comment: { value: message },
        submitter_id: client.current_user.id
      )
    end

    private

    def client
      @client ||= ZendeskAPI::Client.new do |config|
        config.url      = ENV['ZENDESK_API_URI']
        config.username = ENV['ZENDESK_API_USERNAME']
        config.token    = ENV['ZENDESK_API_TOKEN']
      end
    end
  end
end
