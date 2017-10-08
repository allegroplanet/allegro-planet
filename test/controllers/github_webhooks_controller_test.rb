require 'test_helper'

class GithubWebhooksControllerTest < ActionDispatch::IntegrationTest
  def github_webhook
    @github_webhook ||= github_webhooks(:new_pull_request)
  end

  test 'GET #create is successful' do
    post github_webhooks_path, params: { payload: "asdf" }
    assert_response :success
  end

  test 'GET #create creates a new GithubWebhook' do
    GithubWebhook.destroy_all

    payload = '{ "hello": "true" }'
    event = 'pull-request'

    post github_webhooks_path, params: { payload: payload }, headers: { 'X-GitHub-Event' => event }

    assert_equal event, GithubWebhook.first.event
    assert_equal payload, GithubWebhook.first.payload_json
  end

  test 'GET #index is successful' do
    get github_webhooks_path(github_webhook)
    assert_response :success
  end

  test 'GET #index renders the "index" template' do
    get github_webhooks_path(github_webhook)
    assert_template :index
  end
end
