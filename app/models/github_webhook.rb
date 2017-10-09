class GithubWebhook < ApplicationRecord
  before_validation :generate_uuid

  validates :uuid,
    string_format: { rules: [:uuid] }

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid if self.uuid.nil?
  end
end
