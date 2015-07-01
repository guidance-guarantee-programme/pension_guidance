require 'active_model'

class Appointment
  include ActiveModel::Model
  include Draper::Decoratable

  attr_accessor :slot, :name, :surname, :phone, :email, :type, :memorable_word, :postcode

  TYPES = %w(face-to-face phone)

  validates_with EmailValidator, attributes: [:email]

  validates :type, inclusion: { in: TYPES }
  validates :slot, :name, :surname, :phone, presence: true
  validates :memorable_word, presence: true, if: :phone_appointment?
  validates :postcode, presence: true, if: :face_to_face_appointment?

  def slot=(timestamp)
    @slot = Time.zone.parse(timestamp).try(:to_datetime) if timestamp

  rescue ArgumentError
    errors.add(:slot, 'must be a valid datetime')
  end

  def full_name
    "#{name} #{surname}"
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    ticket = AppointmentTicket.new(decorate)
    ticket.create!
  end

  def phone_appointment?
    type == 'phone'
  end

  def face_to_face_appointment?
    type == 'face-to-face'
  end
end
