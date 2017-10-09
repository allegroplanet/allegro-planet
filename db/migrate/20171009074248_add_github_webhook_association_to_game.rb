class AddGithubWebhookAssociationToGame < ActiveRecord::Migration[5.1]
  def change
    add_reference :github_webhooks, :game, foreign_key: true
  end
end
