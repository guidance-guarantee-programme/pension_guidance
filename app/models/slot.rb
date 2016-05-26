class Slot < ActiveRecord::Base
  belongs_to :booking_request

  def to_s
    "#{chosen_date.to_s(:gov_uk)} - #{period}"
  end

  def period
    name == '0800-1200' ? 'Morning' : 'Afternoon'
  end
end
