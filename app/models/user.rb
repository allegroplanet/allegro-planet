class User < ApplicationRecord
  has_secure_password

  before_save { email.downcase! }

  before_validation :generate_handle

  validates :username,
    presence: true,
    length: { maximum: 24, minimum: 2 },
    uniqueness: { case_sensitive: false },
    string_format: { rules: [:only_printable_characters, :starts_with_non_whitespace, :ends_with_non_whitespace] }

  validates :email,
    presence: true,
    length: { maximum: 255 },
    string_format: { rules: [:email] },
    uniqueness: { case_sensitive: false }

  validates :handle,
    presence: true,
    uniqueness: true

  validates :password,
    length: { minimum: 8 },
    string_format: { rules: [:only_printable_characters, :starts_with_non_whitespace, :ends_with_non_whitespace] }

  has_and_belongs_to_many :games

  def to_param
    handle
  end

  private

    def generate_handle
      self.handle ||= self.username.parameterize if self.username.present?
    end
end
