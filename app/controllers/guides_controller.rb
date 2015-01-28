class GuidesController < ApplicationController
  layout 'guides'

  respond_to :html

  def show
    @guide = GuideRepository.new.find(params[:id])

    respond_with @guide
  end
end
