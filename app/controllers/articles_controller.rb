class ArticlesController < ApplicationController
  layout 'articles'

  respond_to :html

  def show
    @article = Article.find(params[:id])

    respond_with @article

  rescue Article::ArticleNotFound
    head 404
  end
end
