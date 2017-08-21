class MarketingController < ApplicationController
  layout false

  def facebook
    @phone_number = '0800 138 3375'
    render :index
  end

  def about
    @phone_number = '0800 138 8287'
    render :index
  end

  def footer?
    false
  end

  def alternate_locales
    []
  end
end
