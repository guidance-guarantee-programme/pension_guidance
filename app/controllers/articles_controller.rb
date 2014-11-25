class ArticlesController < ApplicationController
  layout 'articles'

  respond_to :html

  def show
    @article = ArticleRepository.find(params[:id])

    respond_with @article

  rescue ArticleRepository::ArticleNotFound
    head 404
  end
end
