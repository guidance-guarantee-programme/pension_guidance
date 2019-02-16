class MarketingController < ApplicationController
  layout false

  def landing
    respond_to do |format|
      format.html { render :index }
    end
  end
  alias facebook landing
  alias about landing

  def footer?
    false
  end
end
