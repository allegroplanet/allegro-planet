class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    article = Article.find_by(handle: article_handle_param)

    @title = article.title
    @body_html = MarkdownConverter.new(article.body_markdown).html
  end

  private

  def article_handle_param
    params.permit(:handle)[:handle]
  end
end
