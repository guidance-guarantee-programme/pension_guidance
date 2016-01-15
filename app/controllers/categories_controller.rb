class CategoriesController < ApplicationController
  def show
    @category = CategoryRepository.new.find(params[:id])

    expires_in Rails.application.config.cache_max_age, public: true
  end
end
