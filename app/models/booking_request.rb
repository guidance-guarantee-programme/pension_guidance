class BookingRequest < ActiveRecord::Base
  has_one :primary_slot,   -> { where(position: 1) }, class_name: 'Slot'
  has_one :secondary_slot, -> { where(position: 2) }, class_name: 'Slot'
  has_one :tertiary_slot,  -> { where(position: 3) }, class_name: 'Slot'

  validates :appointment_type, inclusion: { in: %w(55_or_over 50_54) }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :telephone_number, presence: true
  validates :memorable_word, presence: true
  validates :appointment_type, presence: true

  validates :has_defined_contribution_pension,
            presence: true,
            inclusion: {
              in: %w(yes no unknown),
              allow_blank: true,
              message: '%{value} is not a valid value'
            }
end
