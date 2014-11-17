class ArticlesController < ApplicationController
  layout 'articles'

  def show
    article = params[:id]

    render article
  end
end
