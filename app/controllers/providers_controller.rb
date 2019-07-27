class ProvidersController < ApplicationController
  def show
    self.pension_provider = params[:id]

    redirect_to '/en/appointments'
  end
end
