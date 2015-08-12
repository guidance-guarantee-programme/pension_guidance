class SearchResultsController < ApplicationController
  decorates_assigned :search_results, with: SearchResultCollectionDecorator

  def index
    return if params[:query].blank?

    @search_results = Search::PerformSearch.new(params[:query], page: params[:page]).call

    if @search_results.any?
      render :index_with_results
    else
      render :index_no_results
    end
  end
end
