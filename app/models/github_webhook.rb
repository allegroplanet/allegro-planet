class GithubWebhook < ApplicationRecord
  validates :event, length: { maximum: 32 }
end
