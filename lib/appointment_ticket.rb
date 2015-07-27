class AppointmentTicket
  ZENDESK_API_URL = 'https://pensionwise.zendesk.com/api/v2'
  ZENDESK_ONLINE_BOOKING_GROUP = 24_532_022

  def initialize(appointment)
    @appointment = appointment
  end

  def create!
    client.tickets.create(
      type: 'task',
      group_id: ZENDESK_ONLINE_BOOKING_GROUP,
      subject: 'Pension Wise appointment request',
      requester: requester,
      comment: comment)
  end

  private

  def client
    ZendeskAPI::Client.new do |config|
      config.url = ZENDESK_API_URL
      config.username = ENV['ZENDESK_API_USERNAME']
      config.token = ENV['ZENDESK_API_TOKEN']
    end
  end

  def requester
    { name: @appointment.full_name, email: @appointment.email }
  end

  def comment
    <<-TEXT.strip_heredoc
      New appointment request

      Name:
      #{@appointment.full_name}

      Date:
      #{@appointment.date}

      Time:
      #{@appointment.time}

      Appointment type:
      #{@appointment.kind}

      #{info}

      Phone number:
      #{@appointment.phone}

      Email:
      #{@appointment.email}
    TEXT
  end

  def info
    case @appointment.type
    when 'phone'
      <<-TEXT.strip_heredoc
        Memorable word:
        #{@appointment.memorable_word}
      TEXT
    when 'face-to-face'
      <<-TEXT.strip_heredoc
        Postcode:
        #{@appointment.postcode}
      TEXT
    end
  end
end
