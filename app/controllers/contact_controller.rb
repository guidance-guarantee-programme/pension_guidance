class ContactController < ApplicationController
  include Embeddable

  before_action :new_complaint

  def new
  end

  def create
    if verify_recaptcha(model: @complaint, attribute: :robot) && @complaint.send_to_zendesk
      redirect_to contact_path(sent: true, anchor: :complaints)
    else
      render :new
    end
  end

  private

  def new_complaint
    @complaint = Complaint.new(complaint_params)
  end

  def complaint_params
    params
      .fetch(:complaint, {})
      .permit(
        :name,
        :email_address,
        :phone_booking_message,
        :face_to_face_message,
        :other_message
      )
  end
end
