class PersonalDetailsController < ApplicationController
  layout 'full_width'

  def new
    @booking_request = BookingRequest.find(params[:booking_request_id])
  end

  def update
    binding.pry
    @booking_request = BookingRequest.find(params[:booking_request_id])

    if @booking_request.update(personal_details_params)
      redirect_to @booking_request
    else
      render :new
    end
  end

  private

  def personal_details_params
    params
      .require(:booking_request)
      .permit(
        :first_name,
        :last_name,
        :appointment_type,
        :email,
        :telephone_number,
        :memorable_word,
        :opt_in,
        :dc_pot
      )
  end
end
