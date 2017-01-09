class User < ApplicationRecord
  validates :username,
    presence: true,
    length: { maximum: 24 }
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: EmailFormat::EMAIL }
end
