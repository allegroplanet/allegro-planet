require 'test_helper'

class GithubWebhookEventTest < ActiveSupport::TestCase
  def github_webhook_event
    @github_webhook_event ||= GithubWebhookEvent.new(
      github_webhook: github_webhooks(:star_gator),
      event: 'pull-request',
      payload_json: '{ "status": "200" }'
    )
  end

  test 'validates without errors' do
    github_webhook_event.validate
    assert github_webhook_event.errors.empty?
  end

  test 'with a event larger than 32 characters, is invalid' do
    github_webhook_event.event = 'x' * 33
    github_webhook_event.validate
    assert_includes github_webhook_event.errors[:event], 'is too long (maximum is 32 characters)'
  end

  test 'belongs_to a github_webhook' do
    assert_association GithubWebhookEvent, :belongs_to, :github_webhook
  end
end
