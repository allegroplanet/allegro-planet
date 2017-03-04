class MarkdownConverter
  attr_reader :markdown

  def initialize(markdown)
    @markdown = markdown
  end

  def html
    converter.render(@markdown)
  end

  private

  def converter
    @converter ||= Redcarpet::Markdown.new(renderer)
  end

  def renderer
    @renderer ||= Redcarpet::Render::HTML
  end
end
