require 'test_helper'

class MarkdownConverterTest < ActiveSupport::TestCase
  test '#html returns the markdown transformed into HTML' do
    returned_html = MarkdownConverter.new("hello world!").html
    expected_html = "<p>hello world!</p>\n"

    assert_equal expected_html, returned_html
  end

  test '#html automatically converts URLs into clickable links' do
    returned_html = MarkdownConverter.new("link: https://www.allegroplanet.com").html
    expected_html = "<p>link: <a href=\"https://www.allegroplanet.com\">https://www.allegroplanet.com</a></p>\n"

    assert_equal expected_html, returned_html
  end
end
