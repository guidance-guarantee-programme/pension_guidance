class SmarterSignpostingsController < ApplicationController
  def new
    smarter_signposted!

    redirect_to new_telephone_appointment_path
  end

  def destroy
    remove_smarter_signposted!

    redirect_to new_telephone_appointment_path
  end

  private

  def remove_smarter_signposted!
    cookies.permanent[:smarter_signposted] = 'false'
  end

  def smarter_signposted!
    cookies.permanent[:smarter_signposted] = 'true'
  end
end
