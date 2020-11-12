require 'csv'

module MarketingHelper
  def current_campaign
    'paint'
  end

  def campaign_phone_number
    case params[:platform]
    when 'facebook'
      '0800 138 1586'
    when 'google'
      '0800 138 8293'
    when 'linkedin'
      '0800 138 1582'
    else
      '0800 138 3375'
    end
  end
end
