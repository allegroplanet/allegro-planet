class GithubWebhooksController < ApplicationController
  def create
    GithubWebhook.create!(event: github_event_header, payload_json: payload_param)
    render json: { success: true }
  end

  def index
    @webhooks = GithubWebhook.order(created_at: :desc)
  end

  private

  def payload_param
    params[:payload]
  end

  def github_event_header
    request.env['HTTP_X_GITHUB_EVENT']
  end
end
