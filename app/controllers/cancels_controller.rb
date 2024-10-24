class CancelsController < ApplicationController
  include Embeddable

  before_action :cancellation, only: %i[new create]

  def new
  end

  def create
    if @cancellation.valid?
      if TelephoneAppointmentsApi.new.cancel(@cancellation.to_attributes)
        redirect_to success_cancel_path(rebooked_from: verifier.generate(@cancellation.reference))
      else
        redirect_to failure_cancel_path
      end
    else
      render :new
    end
  end

  def success
    @rebooked_from_id = params[:rebooked_from]
  end

  private

  def cancellation
    @cancellation ||= TelephoneCancellation.new(cancellation_params)
  end

  def cancellation_params
    params
      .fetch(:telephone_cancellation, {})
      .permit(
        :reference,
        :date_of_birth_year,
        :date_of_birth_month,
        :date_of_birth_day,
        :reason,
        :other_reason
      )
  end
end
