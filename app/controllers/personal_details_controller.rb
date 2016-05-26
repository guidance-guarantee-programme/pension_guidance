class PersonalDetailsController < ApplicationController
  layout 'full_width'

  def new
    @booking_request = BookingRequest.find(params[:booking_request_id])
  end

  def update
    @booking_request = BookingRequest.find(params[:booking_request_id])

    if @booking_request.update(personal_details_params)
      BookingRequestMailer.customer_confirmation(@booking_request).deliver
      BookingRequestMailer.manager_confirmation.deliver
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
        :existing_annuity,
        :email,
        :telephone_number,
        :memorable_word,
        :opt_in,
        :dc_pot
      )
  end
end
