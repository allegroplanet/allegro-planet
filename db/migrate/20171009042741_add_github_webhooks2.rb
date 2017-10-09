class AddGithubWebhooks2 < ActiveRecord::Migration[5.1]
  def change
    create_table :github_webhooks do |t|
      t.string :uuid

      t.timestamps
    end
  end
end
