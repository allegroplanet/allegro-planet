require 'test_helper'

class MarkdownConverterTest < ActiveSupport::TestCase
  test '#html returns the markdown transformed into HTML' do
    returned_html = MarkdownConverter.new("hello world!").html
    expected_html = "<p>hello world!</p>\n"

    assert_equal expected_html, returned_html
  end
end
