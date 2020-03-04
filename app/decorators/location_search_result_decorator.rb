class LocationSearchResultDecorator < SimpleDelegator
  def coordinates
    lat_lng.join(',')
  end

  def distance
    format('%.2f', super)
  end

  def phone
    Phoner::Phone.parse(twilio_number)&.format('%A %n')
  end
end
