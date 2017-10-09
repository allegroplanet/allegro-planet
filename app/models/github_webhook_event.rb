class GithubWebhookEvent < ApplicationRecord
  belongs_to :github_webhook

  validates :event, length: { maximum: 32 }
end
