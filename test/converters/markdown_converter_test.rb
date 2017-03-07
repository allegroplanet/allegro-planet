require 'test_helper'

class MarkdownConverterTest < ActiveSupport::TestCase
  test '#html returns the markdown transformed into HTML' do
    returned_html = MarkdownConverter.new("hello world!").html
    expected_html = "<p>hello world!</p>\n"

    assert_equal expected_html, returned_html
  end

  test "#html will return an empty string if source text isn't present" do
    blank_values = ["", " ", nil, []]

    blank_values.each do |blank_value|
      returned_html = MarkdownConverter.new(blank_value).html
      assert_equal '', returned_html
    end
  end

  test '#html automatically converts URLs into clickable links' do
    returned_html = MarkdownConverter.new("link: https://www.allegroplanet.com").html
    expected_html = "<p>link: <a href=\"https://www.allegroplanet.com\">https://www.allegroplanet.com</a></p>\n"

    assert_equal expected_html, returned_html
  end

  test '#html safely escapes HTML characters and does not generate inline HTML' do
    markdown_with_inline_html = "<script>alert('haxed');</script>"
    returned_html = MarkdownConverter.new(markdown_with_inline_html).html
    expected_escaped_html = "<p>&lt;script&gt;alert(&#39;haxed&#39;);&lt;/script&gt;</p>"

    refute_match markdown_with_inline_html, returned_html
    assert_match expected_escaped_html, returned_html
 end
end
