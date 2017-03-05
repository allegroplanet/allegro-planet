class GameReleaseDecorator
  def initialize(game_release)
    @game_release = game_release
  end

  def version_num
    @game_release.version_num
  end

  def game_files
    @game_files ||= @game_release.game_files.each.collect do |release|
      {
        category: release.category,
        url:      "https://#{Figaro.env.aws_allegro_planet_bucket}.s3.amazonaws.com/#{release.file.path}"
      }
    end
  end

  def notes
    MarkdownConverter.new(@game_release.notes).html
  end
end
