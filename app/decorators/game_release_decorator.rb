class GameReleaseDecorator
  def initialize(game_release)
    @game_release = game_release
  end

  def version_num
    @game_release.version_num
  end

  def game_files
    @game_files ||= @game_release.game_files.each.collect do |game_file|
      {
        category: game_file.category,
        url:      "https://#{Figaro.env.aws_allegro_planet_bucket}.s3.amazonaws.com/#{game_file.file.path}"
      }
    end
  end

  def notes
    MarkdownConverter.new(@game_release.notes).html
  end
end
