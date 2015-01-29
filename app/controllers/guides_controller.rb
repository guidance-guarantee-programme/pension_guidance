class GuidesController < ApplicationController
  layout 'guides'

  def show
    @guide = GuideRepository.new.find(params[:id])
  end
end
