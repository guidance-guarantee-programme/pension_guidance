class SearchResultsController < ApplicationController
  decorates_assigned :search_results, with: SearchResultCollectionDecorator

  def index
    return if params[:query].blank?

    @search_results = Search::PerformSearch.new(params[:query], page: params[:page]).call

    render @search_results.any? ? :index_with_results : :index_no_results
  end
end
