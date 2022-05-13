class NudgesController < ApplicationController
  def new
    redirect_to redirect_path
  end

  private

  def redirect_path
    if embedded?
      nudge_telephone_appointments_path
    else
      new_telephone_appointment_path(nudged: true)
    end
  end

  def embedded?
    params[:embedded] == 'true'
  end
end
