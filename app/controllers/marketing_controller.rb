class MarketingController < ApplicationController
  layout false

  def landing
    @campaign = 'dogs'
    @phone_number = '0800 138 3375'

    respond_to do |format|
      format.html { render :index }
    end
  end

  def facebook
    @campaign = 'dogs'
    @phone_number = '0800 138 3375'

    respond_to do |format|
      format.html { render :index }
    end
  end

  def about
    @campaign = 'peppers'
    @phone_number = '0800 138 3375'

    respond_to do |format|
      format.html { render :index }
    end
  end

  def footer?
    false
  end
end
