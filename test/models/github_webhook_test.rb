require 'test_helper'

class GithubWebhookTest < ActiveSupport::TestCase
  def github_webhook
    @github_webhook ||= GithubWebhook.new(event: 'pull-request', payload_json: '{ "status": "200" }')
  end

  test 'validates without errors' do
    github_webhook.validate
    assert github_webhook.errors.empty?
  end

  test 'with a event larger than 32 characters, is invalid' do
    github_webhook.event = 'x' * 33
    github_webhook.validate
    assert_includes github_webhook.errors[:event], 'is too long (maximum is 32 characters)'
  end

  test 'with a payload_json larger than 512 characters, is invalid' do
    github_webhook.payload_json = 'x' * 516
    github_webhook.validate
    assert_includes github_webhook.errors[:payload_json], 'is too long (maximum is 512 characters)'
  end
end
