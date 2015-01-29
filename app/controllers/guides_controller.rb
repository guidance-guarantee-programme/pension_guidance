class GuidesController < ApplicationController
  layout 'guides'

  def show
    @guide = GuideRepository.new.find(params[:id])

    expires_in Rails.application.config.cache_max_age, public: true
  end
end
