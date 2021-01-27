class Complaint
  include ActiveModel::Model

  NATURE_OF_COMPLAINT = %w(
    phone_booking_message
    face_to_face_message
    other_message
  ).freeze

  attr_accessor :nature_of_complaint
  attr_accessor :name, :email_address
  attr_accessor :phone_booking_message, :face_to_face_message, :other_message

  validates :name, presence: true
  validates :email_address, email: true, allow_blank: true
  validates :nature_of_complaint, inclusion: { in: NATURE_OF_COMPLAINT }

  NATURE_OF_COMPLAINT.each do |nature_of_complaint|
    validates nature_of_complaint,
              presence: true,
              if: ->(complaint) { complaint.nature_of_complaint == nature_of_complaint }
  end

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
      message: message,
      tags: %w(complaint)
    }
  end

  def message
    return '' if nature_of_complaint.blank?

    public_send(nature_of_complaint)
  end
end
