class AddGithubWebhooks < ActiveRecord::Migration[5.1]
  def change
    create_table :github_webhooks do |t|
      t.string :event
      t.text :payload_json
      t.timestamps
    end
  end
end
