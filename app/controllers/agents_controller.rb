class AgentsController < ApplicationController
  def show
    if agent?
      head :ok, location: tap_new_appointment_url
    else
      head :not_found
    end
  end

  private

  def tap_new_appointment_url
    "#{ENV['TAP_APPOINTMENTS_API_URI']}/appointments/new"
  end
end
