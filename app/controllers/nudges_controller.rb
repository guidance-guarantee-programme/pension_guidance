class NudgesController < ApplicationController
  NUDGE_COOKIE = 'nudged'.freeze
  EMBED_COOKIE = 'embedded'.freeze

  def new
    nudged!

    redirect_to redirect_path
  end

  private

  def redirect_path
    if embedded?
      nudge_telephone_appointments_path
    else
      new_telephone_appointment_path
    end
  end

  def embedded?
    params[:embedded] == 'true'
  end

  def nudged!
    cookies.permanent[NUDGE_COOKIE] = 'true'
    cookies.permanent[EMBED_COOKIE] = 'true' if embedded?
  end
end
