class ArticlesController < ApplicationController
  layout 'articles'

  respond_to :html

  def show
    @article = ArticleRepository.new.find(params[:id])

    respond_with @article
  end
end
