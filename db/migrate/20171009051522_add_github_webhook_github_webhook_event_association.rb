class AddGithubWebhookGithubWebhookEventAssociation < ActiveRecord::Migration[5.1]
  def change
    add_reference :github_webhook_events, :github_webhook, foreign_key: true
  end
end
