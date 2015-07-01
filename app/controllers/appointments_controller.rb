class AppointmentsController < ApplicationController
  layout 'guides'

  def index
    render layout: 'appointments'
  end

  def new
    @appointment = Appointment.new
    @availability = Availability.new.decorate
  end

  def reserve
    @appointment = Appointment.new(params[:appointment]).decorate
  end

  def create
    @appointment = Appointment.new(params[:appointment]).decorate

    if @appointment.save
      redirect_to action: 'thanks'
    else
      render 'reserve'
    end
  end
end
