class ArticlesController < ApplicationController
  def index
    @articles = Article.published
  end

  def show
    article = Article.published.find_by(handle: article_handle_param) or record_not_found

    @title = article.title
    @body_html = MarkdownConverter.new(article.body_markdown).html
  end

  private

  def article_handle_param
    params.permit(:handle)[:handle]
  end
end
