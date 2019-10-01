class ReferralsController < ApplicationController
  layout 'full_width'

  before_action :verify_agent

  def new
    return redirect_to edit_referral_path if unresolved_referral

    @referral = Referral.new(agent_identifier: agent_identifier)
  end

  def create
    @referral = Referral.new(referral_params)

    if @referral.save
      redirect_to guide_path('appointments')
    else
      render :new
    end
  end

  def edit
    return redirect_to new_referral_path unless @referral = unresolved_referral # rubocop:disable AssignmentInCondition
  end

  def update
    return redirect_to new_referral_path unless @referral = unresolved_referral # rubocop:disable AssignmentInCondition

    if @referral.update(referral_params)
      redirect_to guide_path('appointments')
    else
      render :edit
    end
  end

  private

  def verify_agent
    return redirect_to root_path, status: :unauthorized unless agent?
  end

  def referral_params
    munge_date_params!

    params.require(:referral).permit(
      :surname,
      :pension_provider,
      :date_of_birth,
      :call_outcome,
      :agent_identifier
    )
  end

  def munge_date_params!
    referral_date_params = params[:referral]

    if referral_date_params
      year  = referral_date_params.delete('date_of_birth(1i)')
      month = referral_date_params.delete('date_of_birth(2i)')
      day   = referral_date_params.delete('date_of_birth(3i)')
    end

    referral_date_params[:date_of_birth] = "#{year}-#{month}-#{day}" if year && month && day
  end
end
