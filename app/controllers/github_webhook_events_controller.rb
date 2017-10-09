class GithubWebhookEventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    GithubWebhookEvent.create!(event: github_event_header, payload_json: payload_param)
    render json: { success: true }
  end

  def index
    @webhooks = GithubWebhookEvent.order(created_at: :desc)
  end

  def show
    @webhook = GithubWebhookEvent.find(id_param)
  end

  private

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
