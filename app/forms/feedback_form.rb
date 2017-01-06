class FeedbackForm
  include ActiveModel::Model

  attr_accessor :name, :email, :message, :feedback_type

  validates :name, presence: true
  validates :email, presence: true, format: { with: /.+@.+\..+/ }
  validates :message, presence: true
  validates :feedback_type, inclusion: { in: %w(online_booking pension_type_tool) }

  def self.for_online_booking
    new(feedback_type: 'online_booking')
  end

  def message_content
    message_identifier.merge(
      name: name,
      email: email,
      message: message
    )
  end

  def message_identifier
    {
      'online_booking' => {
        subject: 'Online Booking zen_desk',
        tags: %w(online_booking)
      },
      'pension_type_tool' => {
        subject: 'Pension type tool zen_desk',
        tags: %w(pension_type_tool)
      }
    }[feedback_type]
  end
end
