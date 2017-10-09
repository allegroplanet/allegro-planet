class GithubWebhook < ApplicationRecord
  before_validation :generate_uuid

  belongs_to :game
  has_many :events, class_name: GithubWebhookEvent.to_s

  validates :uuid,
    string_format: { rules: [:uuid] }

  validates :game,
    presence: true

  def to_param
    uuid
  end

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid if self.uuid.nil?
  end
end
