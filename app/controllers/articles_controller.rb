class ArticlesController < ApplicationController
  layout 'articles'

  def show
    article = params[:id].tr('-', '_')

    if template_exists?(article, 'articles')
      render article
    else
      head 404
    end

  end
end
