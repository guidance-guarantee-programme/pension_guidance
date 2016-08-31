class AnnuityRegistrationController < ApplicationController
  layout 'guides'

  def new
    @annuity_registration = AnnuityRegistrationForm.new
  end

  def create
    @annuity_registration = AnnuityRegistrationForm.new(annuities_registration_params)
    if @annuity_registration.valid?
      ZenDesk.create_ticket(@annuity_registration.message_content)
      redirect_to annuity_registration_success_path
    else
      render :new
    end
  end

  def success
  end

  def annuities_registration_params
    params.require(:annuity_registration).permit(*AnnuityRegistrationForm::FIELDS)
  end
end
