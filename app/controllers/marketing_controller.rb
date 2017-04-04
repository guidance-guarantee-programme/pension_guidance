class MarketingController < ApplicationController
  layout false

  def facebook
    @phone_number = '0800 138 3375'
    render :index
  end

  def pp
    @phone_number = '0800 138 8287'
    render :index
  end

  def footer?
    false
  end
end
