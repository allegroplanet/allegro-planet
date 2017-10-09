class GithubWebhook < ApplicationRecord
  before_validation :generate_uuid

  has_many :github_webhook_events

  validates :uuid,
    string_format: { rules: [:uuid] }

  def to_param
    uuid
  end

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid if self.uuid.nil?
  end
end
