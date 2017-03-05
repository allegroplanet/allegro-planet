class GameReleaseDecorator
  def initialize(game_release)
    @game_release = game_release
  end

  def version_num
    @game_release.version_num
  end

  def game_files
    @game_release.game_files
  end

  def notes
    MarkdownConverter.new(@game_release.notes).html
  end
end
