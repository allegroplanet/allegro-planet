class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find_by(handle: params[:handle]) or record_not_found
    @description = MarkdownConverter.new(@game.description).html
    @screenshot_urls = @game.game_screenshots.collect { |s| s.public_url }
    @releases = @game.game_releases.collect { |r| GameReleaseDecorator.new(r) }
  end
end
