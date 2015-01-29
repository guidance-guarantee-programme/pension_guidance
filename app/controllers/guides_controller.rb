class GuidesController < ApplicationController
  layout 'guides'

  def show
    @guide = GuideRepository.new.find(params[:id])

    expires_in ENV['CACHE_MAX_AGE'] || 10.seconds, public: true
  end
end
