class CategoriesController < ApplicationController
  def show
    @category_navigation = CreateCategoryNavigation.new(params[:id], Taxonomy.instance.tree).call

    expires_in Rails.application.config.cache_max_age, public: true
  end

  def content_lang_matches_locale?
    true
  end
end
