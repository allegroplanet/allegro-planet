require 'test_helper'

class GithubWebhookEventTest < ActiveSupport::TestCase
  def github_webhook_event
    @github_webhook_event ||= GithubWebhookEvent.new(event: 'pull-request', payload_json: '{ "status": "200" }')
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
end
