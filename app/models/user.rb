class User < ApplicationRecord
  validates :username,
    presence: true,
    length: { maximum: 24 },
    uniqueness: { case_sensitive: false }
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: EmailFormat::EMAIL },
    uniqueness: { case_sensitive: false }
end
