class User < ApplicationRecord
  has_secure_password

  before_save { email.downcase! }

  before_validation :generate_handle

  has_and_belongs_to_many :games

  validates :username,
    presence: true,
    length: { maximum: 24, minimum: 2 },
    uniqueness: { case_sensitive: false },
    string_format: { rules: [:username_characters, :starts_with_non_whitespace, :ends_with_non_whitespace, :at_least_one_alphanumeric_character] }
  validates :email,
    presence: true,
    length: { maximum: 255 },
    string_format: { rules: [:email] },
    uniqueness: { case_sensitive: false }
  validates :handle,
    presence: true,
    uniqueness: true
  validates :password,
    length: { minimum: 3 },
    string_format: { rules: [:only_printable_characters] },
    allow_nil: true

  def to_param
    handle
  end

  private

    def generate_handle
      self.handle ||= self.username.parameterize if self.username.present?
    end
end
