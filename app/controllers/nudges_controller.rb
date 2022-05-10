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
    cookies[NUDGE_COOKIE] = cookie_value
    cookies[EMBED_COOKIE] = cookie_value if embedded?
  end

  def cookie_value
    return 'true' unless Rails.env.production?

    { value: 'true', same_site: 'None', httponly: true, secure: true }
  end
end
