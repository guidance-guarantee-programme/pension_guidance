class BookingFeedbackForm
  include ActiveModel::Model

  attr_accessor :name, :email, :message

  validates :name, presence: true
  validates :email, presence: true, format: { with: /.+@.+\..+/ }
  validates :message, presence: true

  def message_content
    {
      name: name,
      email: email,
      message: message,
      subject: 'Online Booking zen_desk',
      tags: %w(online_booking)
    }
  end
end
