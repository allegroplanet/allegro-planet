class GithubWebhook < ApplicationRecord
  validates :event, length: { maximum: 32 }
  validates :payload_json, length: { maximum: 512 }
end
