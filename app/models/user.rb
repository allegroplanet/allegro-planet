class User < ApplicationRecord
  before_save { email.downcase! }
  before_validation :generate_slug
  validates :username,
    presence: true,
    length: { maximum: 24 },
    uniqueness: { case_sensitive: false }
  validates :username, format: { with: StringFormat::ONLY_PRINTABLE_CHARACTERS,
                                 message: 'can only contain printable characters' }
  validates :username, format: { with: StringFormat::STARTS_WITH_NON_WHITESPACE,
                                 message: 'can not start with whitespace' }
  validates :username, format: { with: StringFormat::ENDS_WITH_NON_WHITESPACE,
                                 message: 'can not end with whitespace' }
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: EmailFormat::EMAIL },
    uniqueness: { case_sensitive: false }
  validates :slug,
    presence: true,
    uniqueness: true
  has_secure_password
  validates :password, format: { with: StringFormat::EIGHT_OR_MORE_CHARACTERS,
                                 message: 'must have 8 or more characters' }
  validates :password, format: { with: StringFormat::CONTAINS_A_DIGIT,
                                 message: 'must have at least one digit' }
  validates :password, format: { with: StringFormat::STARTS_WITH_NON_WHITESPACE,
                                 message: 'can not start with whitespace' }
  validates :password, format: { with: StringFormat::ENDS_WITH_NON_WHITESPACE,
                                 message: 'can not end with whitespace' }

  private

    def generate_slug
      self.slug ||= self.username.parameterize if self.username.present?
    end
end
