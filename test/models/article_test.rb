require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "title must be present and cannot be blank" do
    article = articles(:basic_tutorial)

    invalid_title_values = [ nil, "", ]

    invalid_title_values.each do |invalid_title_value|
      article.title = invalid_title_value
      article.validate
      assert_includes article.errors[:title], "can't be blank"
    end
  end

  test "title obeys the the expected string format rules" do
    article = articles(:basic_tutorial)

    invalid_titles = [
      {
        title: " Article Title!",
        expected_error_message: "can't start with whitespace",
      },
      {
        title: "Article Title! ",
        expected_error_message: "can't end with whitespace",
      },
      {
        title: "\nTitle\n",
        expected_error_message: "can only contain printable characters",
      },
    ]

    invalid_titles.each do |invalid_title|
      article.title = invalid_title[:title]
      article.validate
      assert_includes article.errors[:title], invalid_title[:expected_error_message]
    end
  end

  test "title must be unique" do
    article = Article.new(title: articles(:basic_tutorial).title)
    article.validate
    assert_includes article.errors[:title], 'has already been taken'
  end

  test "handle, when not present, one is automatically generated from the title" do
    article = Article.new(title: 'A Most Fantastical Journey')
    article.validate

    expected_handle = 'a-most-fantastical-journey'
    assert_equal expected_handle, article.handle
    assert_empty article.errors[:handle]
  end

  test "handle cannot be blank" do
    article = Article.new
    article.validate

    assert_includes article.errors[:handle], "can't be blank"
  end

  test "handle is sticky (it does not change if the title changes)" do
    article = articles(:basic_tutorial)
    previous_handle = article.handle

    article.title = 'A Completely Different Title Than Before'
    article.validate
    assert_equal previous_handle, article.handle
  end

  test "handle, despite being sticky, can be set manually" do
    article = articles(:basic_tutorial)
    new_handle = 'a-different-handle-than-what-is-currently-the-handle'
    article.handle = new_handle
    article.validate

    assert_equal new_handle, article.handle
  end

  test "handle obeys the the expected string format rules" do
    article = articles(:basic_tutorial)

    invalid_handles = [
      {
        handle: " a-handle-that-starts-with-whitespace",
        expected_error_message: "can't start with whitespace",
      },
      {
        handle: "a-handle-that-ends-with-whitespace ",
        expected_error_message: "can't end with whitespace",
      },
      {
        handle: "a-handle\twith-non-printable\tcharacters",
        expected_error_message: "can only contain printable characters",
      },
    ]

    invalid_handles.each do |invalid_handle|
      article.handle = invalid_handle[:handle]
      article.validate
      assert_includes article.errors[:handle], invalid_handle[:expected_error_message]
    end
  end

  test "handle must be unique" do
    article = Article.new(handle: articles(:basic_tutorial).handle)
    article.validate
    assert_includes article.errors[:handle], 'has already been taken'
  end

  test "belongs to a user" do
    assert_association Article, :belongs_to, :user
  end

  test "user must exist" do
    article = articles(:basic_tutorial)
    article.user = nil
    article.validate

    assert_includes article.errors[:user], 'must exist'
  end

  test "uses the handle as the param" do
    article = articles(:basic_tutorial)
    expected_param = 'basic-tutorial'

    assert_equal expected_param, article.to_param
  end
end
