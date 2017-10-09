class RenameGithubWebhookToGithubWebhookEvent < ActiveRecord::Migration[5.1]
  def up
    rename_table :github_webhooks, :github_webhook_events
  end

  def down
    rename_table :github_webhook_events, :github_webhooks
  end
end
