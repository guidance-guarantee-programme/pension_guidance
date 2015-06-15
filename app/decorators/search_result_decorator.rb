class SearchResultDecorator < SimpleDelegator
  def distance
    format('%.2f', __getobj__.distance)
  end
end
