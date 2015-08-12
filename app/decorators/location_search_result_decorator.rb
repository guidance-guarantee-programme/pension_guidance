class LocationSearchResultDecorator < SimpleDelegator
  def address
    __getobj__.address.gsub("\n", ', ').squish
  end

  def distance
    format('%.2f', __getobj__.distance)
  end
end
