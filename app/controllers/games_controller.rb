class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @screenshot_urls = @game.game_screenshots.collect { |s| s.image.url }
  end
end
