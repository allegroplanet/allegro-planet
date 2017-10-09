class GithubWebhookEventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    github_webhook = GithubWebhook.find_by(uuid: github_webhook_uuid_param)
    game = Game.find_by!(handle: game_handle_param)

    unless github_webhook.game.eql?(game)
      raise ArgumentError, "There is no webhook #{github_webhook_uuid_param} for the game #{game_handle_param}"
    end

    GithubWebhookEvent.create!(github_webhook: github_webhook, event: github_event_header, payload_json: payload_param)

    render json: { success: true }
  end

  def index
    @webhooks = GithubWebhookEvent.order(created_at: :desc)
  end

  def show
    @webhook = GithubWebhookEvent.find(id_param)
  end

  private

  def game_handle_param
    params[:game_handle]
  end

  def github_webhook_uuid_param
    params[:github_webhook_uuid]
  end

  def id_param
    params[:id]
  end

  def payload_param
    request.raw_post
  end

  def github_event_header
    request.env['HTTP_X_GITHUB_EVENT']
  end
end
