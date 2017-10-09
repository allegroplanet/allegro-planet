require 'test_helper'

class GithubWebhookTest < ActiveSupport::TestCase
  def github_webhook
    @github_webhook ||= GithubWebhook.new(game: Game.first)
  end

  test 'can be created' do
    github_webhook.validate
    assert github_webhook.errors.empty?
  end

  test 'generates a uuid on validation' do
    assert github_webhook.uuid.nil?
    github_webhook.validate
    refute github_webhook.uuid.nil?
  end

  test 'without a game, is invalid' do
    github_webhook.game = nil
    github_webhook.validate
    assert_includes github_webhook.errors[:game], "can't be blank"
  end

  test 'has many github webhook events as "events"' do
    assert_association GithubWebhook, :has_many, :events
  end

  test 'belongs to a game' do
    assert_association GithubWebhook, :belongs_to, :game
  end

  test 'uuid is formatted with the expected rules' do
    expected_validation_rules = [:uuid]
    assert_validates_format_rules expected_validation_rules, GithubWebhook, :uuid
  end

  test 'returns its uuid as its param' do
    github_webhook = github_webhooks(:star_gator)
    assert_equal github_webhook.uuid, github_webhook.to_param
  end
end
