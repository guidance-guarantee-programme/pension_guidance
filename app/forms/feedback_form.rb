class FeedbackForm
  include ActiveModel::Model

  attr_accessor :name, :email, :message, :feedback_type

  validates :name, presence: true
  validates :email, email: true
  validates :message, presence: true
  validates :feedback_type, inclusion: { in: %w(phone_booking tesco online_booking pension_type_tool) }

  def self.for_face_to_face_booking
    new(feedback_type: 'online_booking')
  end

  def self.for_phone_booking
    new(feedback_type: 'phone_booking')
  end

  def self.for_tesco
    new(feedback_type: 'tesco')
  end

  def message_content
    message_identifier.merge(
      name: name,
      email: email,
      message: message
    )
  end

  def message_identifier # rubocop:disable Metrics/MethodLength
    {
      'tesco' => {
        subject: 'Tesco Online Booking zen_desk',
        tags: %w(tesco)
      },
      'online_booking' => {
        subject: 'Face-to-Face Online Booking zen_desk',
        tags: %w(online_booking f2f)
      },
      'phone_booking' => {
        subject: 'Phone Online Booking zen_desk',
        tags: %w(online_booking phone)
      },
      'pension_type_tool' => {
        subject: 'Pension type tool zen_desk',
        tags: %w(pension_type_tool)
      }
    }[feedback_type]
  end
end
