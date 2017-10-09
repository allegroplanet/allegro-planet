require 'test_helper'

class GithubWebhookEventsControllerTest < ActionDispatch::IntegrationTest
  def github_webhook
    @github_webhook ||= GithubWebhook.first
  end

  def github_webhook_event
    @github_webhook_event ||= github_webhook_events(:new_pull_request)
  end

  test 'GET #create is successful' do
    post github_webhook_github_webhook_events_path(github_webhooks(:star_gator)),
      params: { payload: "asdf" },
      headers: { 'X-GitHub-Event' => 'test-event' }
    assert_response :success
  end

  test 'GET #create creates a new GithubWebhookEvent' do
    GithubWebhookEvent.destroy_all

    payload = '{ "hello": "true" }'
    event = 'pull-request'

    post github_webhook_github_webhook_events_path(github_webhooks(:star_gator)),
      params: { payload: payload },
      headers: { 'X-GitHub-Event' => event }

    assert_equal event, GithubWebhookEvent.first.event
    assert_equal request.raw_post, GithubWebhookEvent.first.payload_json
    assert_equal github_webhook, GithubWebhookEvent.first.github_webhook
  end

  test 'GET #show is successful' do
    get github_webhook_github_webhook_event_path(github_webhooks(:star_gator), github_webhook_event)
    assert_response :success
  end

  test 'GET #show renders the "show" template' do
    get github_webhook_github_webhook_event_path(github_webhooks(:star_gator), github_webhook_event)
    assert_template :show
  end

  test 'GET #index is successful' do
    get github_webhook_github_webhook_events_path(github_webhooks(:star_gator))
    assert_response :success
  end

  test 'GET #index renders the "index" template' do
    get github_webhook_github_webhook_events_path(github_webhooks(:star_gator))
    assert_template :index
  end
end
