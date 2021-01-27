class ContactController < ApplicationController
  layout 'guides'

  before_action :new_complaint

  def new
  end

  def create
    if @complaint.send_to_zendesk
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
        :nature_of_complaint,
        :phone_booking_message,
        :face_to_face_message,
        :other_message
      )
  end
end
