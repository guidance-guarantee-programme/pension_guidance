class Complaint
  include ActiveModel::Model

  attr_accessor :name, :email_address
  attr_accessor :phone_booking_message, :face_to_face_message, :other_message

  validates :name, presence: true
  validates :email_address, email: true, allow_blank: true

  def send_to_zendesk
    ZenDesk.create_ticket(zendesk_content) if valid?

    valid?
  end

  def requester_email
    return email_address if email_address.present?

    'zendesk@pensionwise.gov.uk'
  end

  private

  def zendesk_content
    {
      subject: 'Complaint',
      name: name,
      email: requester_email,
      message: combined_message,
      tags: %w(complaint)
    }
  end

  def combined_message # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @combined_message ||= begin
      @combined_message = ''

      if phone_booking_message.present?
        @combined_message << "About a Phone Booking\n"
        @combined_message << "---------------------\n"
        @combined_message << "#{phone_booking_message}\n\n"
      end

      if face_to_face_message.present?
        @combined_message << "About a Face to Face Booking\n"
        @combined_message << "---------------------\n"
        @combined_message << "#{face_to_face_message}\n\n"
      end

      if other_message.present?
        @combined_message << "About something else\n"
        @combined_message << "---------------------\n"
        @combined_message << other_message
      end

      @combined_message
    end
  end
end
