class LocationSearchResultDecorator < SimpleDelegator
  def address_flattened
    __getobj__.address.gsub("\n", ', ').squish
  end

  def distance
    format('%.2f', __getobj__.distance)
  end

  def phone
    return formated_twilio_number unless twilio_number.blank?
    return _booking_location.phone unless _booking_location.nil?

    super
  end

  private

  def formated_twilio_number
    Phoner::Phone.parse(twilio_number).format('%A %n')
  end
end
