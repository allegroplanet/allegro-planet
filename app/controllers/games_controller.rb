class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find_by(handle: params[:handle]) or record_not_found
    @screenshot_urls = @game.game_screenshots.collect { |s| s.image.url }
    @releases = @game.game_releases
  end
end
