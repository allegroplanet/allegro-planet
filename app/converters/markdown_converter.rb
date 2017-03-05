class MarkdownConverter
  attr_reader :markdown

  def initialize(markdown)
    @markdown = markdown
  end

  def html
    @html ||= converter.render(@markdown).html_safe
  end

  private

  def converter
    @converter ||= Redcarpet::Markdown.new(renderer, autolink: true)
  end

  def renderer
    @renderer ||= Redcarpet::Render::HTML
  end
end
