class SearchResultCollectionDecorator < Draper::CollectionDecorator
  delegate :per_page

  def decorator_class
    SearchResultDecorator
  end

  def context
    { query: object.query }
  end

  def page
    if object.page > number_of_pages
      number_of_pages
    else
      object.page
    end
  end

  def total_results
    if object.total_results > result_limit
      result_limit
    else
      object.total_results
    end
  end

  def first_page?
    page == 1
  end

  def last_page?
    page == number_of_pages
  end

  def previous_page
    first_page? ? nil : page - 1
  end

  def next_page
    last_page? ? nil : page + 1
  end

  def number_of_pages
    total_results <= per_page ? 1 : (((total_results - 1) / per_page) + 1)
  end

  private

  def search_path(query)
    helper.search_results_path(query: query)
  end

  def result_limit
    Search::PerformSearch::PAGE_LIMIT * Search::PerformSearch::DEFAULT_PER_PAGE
  end
end
