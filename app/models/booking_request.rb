require 'securerandom'

class BookingRequest < ActiveRecord::Base
  SLOT_REGEX = /^(\d{4}-\d{2}-\d{2})-(\d{4}-\d{4})$/

  before_create :generate_reference_number

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

  validates :dc_pot, presence: true

  def slots_from(params)
    %i(primary_slot secondary_slot tertiary_slot).each do |slot_param|
      if params[slot_param] =~ SLOT_REGEX
        slot = public_send("build_#{slot_param}")
        slot.chosen_date = Date.parse($1)
        slot.name = $2
      end
    end
  end

  private

  def generate_reference_number
    self.reference_number ||= SecureRandom.hex(4)
  end
end
