class NudgesController < ApplicationController
  NUDGE_COOKIE = 'nudged'.freeze

  def new
    nudged!

    redirect_to new_telephone_appointment_path
  end

  private

  def nudged!
    cookies.permanent[NUDGE_COOKIE] = 'true'
  end
end
