class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find_by(slug: params[:slug]) or record_not_found
    @screenshot_urls = @game.game_screenshots.collect { |s| s.image.url }
  end
end
