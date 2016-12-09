class FeedbackController < ApplicationController
  require 'zendesk_api'
  layout 'full_width'

  def feedback
    @booking_feedback = BookingFeedbackForm.new(booking_feedback_params)

    create_ticket if @booking_feedback.valid?

    return unless request.xhr?
    status = @booking_feedback.invalid? ? :bad_request : :ok

    render partial: 'feedback/result',
           status: status
  end

  private

  def client
    @client ||= ZendeskAPI::Client.new do |config|
      config.url = 'https://pensionwise.zendesk.com/api/v2'

      config.username = ENV.fetch('ZENDESK_API_USERNAME', '')
      config.token = ENV.fetch('ZENDESK_API_TOKEN', '')
    end
  end

  def create_ticket
    return true if Rails.env.development? || Rails.env.test?

    ZendeskAPI::Ticket.create!(
      client,
      subject: 'Online Booking feedback',
      comment: {
        value: feedback_comment
      },
      submitter_id: client.current_user.id,
      tags: %w(online_booking)
    )
  end

  def booking_feedback_params
    params
      .fetch(:booking_feedback, {})
      .permit(
        :name,
        :email,
        :message
      )
  end

  def feedback_comment
    <<~eos
      Name: #{@booking_feedback.name}
      Email: #{@booking_feedback.email}

      Message: #{@booking_feedback.message}
    eos
  end
end
