class EdgarHTMLConverter
  attr_reader :initial_content

  def initialize(initial_content:)
    @initial_content = initial_content
  end

  def html
  end

  private

  def html_doc
    html = "<html><body><h1>Mr. Belvedere Fan Club</h1></body></html>"
    Nokogiri::HTML(html);
  end
end
