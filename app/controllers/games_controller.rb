class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find_by(handle: params[:handle]) or record_not_found
    @description = MarkdownConverter.new(@game.description).html
    @feature_screenshot_urls = feature_screenshot_urls
    @releases = @game.game_releases.collect { |r| GameReleaseDecorator.new(r) }
    @developers = developers
  end

  def feature_screenshot_urls
    @screenshot_urls ||= @game.game_screenshots.collect do |s|
      s.feature_public_url
    end
  end

  def developers
    developers ||= @game.users.map do |user|
      view_context.link_to(user.username, user)
    end.to_sentence.html_safe
  end
end
