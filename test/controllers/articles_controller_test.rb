require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'GET #index is successful' do
    get articles_url
    assert_response :success
  end

  test 'GET #index lists published articles' do
    expected_article_titles = Article.published.pluck(:title)
    refute_empty expected_article_titles

    get articles_url

    expected_article_titles.each do |expected_article_title|
      assert_match expected_article_title, response.body
    end
  end

  test 'GET #index does not list unpublished articles' do
    unexpected_article_titles = Article.where(published: false).pluck(:title)
    refute_empty unexpected_article_titles

    get articles_url

    unexpected_article_titles.each do |unexpected_article_title|
      refute_match unexpected_article_title, response.body
    end
  end

  test 'GET #show is successful' do
    get article_path(articles(:basic_tutorial))
    assert_response :success
  end

  test 'GET #show includes the article title and body converted from markdown' do
    article = articles(:basic_tutorial)
    get article_path(article)

    expected_article_title = article.title
    expected_article_body = MarkdownConverter.new(article.body_markdown).html

    assert_match expected_article_title, response.body
    assert_match expected_article_body, response.body
  end

  test 'GET #show will raise RecordNotFound when attempting to view an unpublished article' do
    unpublished_article = articles(:an_unpublished_tutorial)

    assert_raise ActiveRecord::RecordNotFound do
      get article_path(unpublished_article)
    end
  end
end
