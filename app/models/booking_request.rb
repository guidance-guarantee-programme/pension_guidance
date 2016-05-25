class BookingRequest < ActiveRecord::Base
  has_one :primary_slot,   -> { where(position: 1) }, class_name: 'Slot'
  has_one :secondary_slot, -> { where(position: 2) }, class_name: 'Slot'
  has_one :tertiary_slot,  -> { where(position: 3) }, class_name: 'Slot'
end
