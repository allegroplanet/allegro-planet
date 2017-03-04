class User < ApplicationRecord
  has_secure_password

  before_save { email.downcase! }

  before_validation :generate_handle

  validates :username,
    presence: true,
    length: { maximum: 24 },
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

  validates :password, format: { with: StringFormat::EIGHT_OR_MORE_CHARACTERS,
                                 message: 'must have 8 or more characters' }
  validates :password, format: { with: StringFormat::STARTS_WITH_NON_WHITESPACE,
                                 message: 'can not start with whitespace' }
  validates :password, format: { with: StringFormat::ENDS_WITH_NON_WHITESPACE,
                                 message: 'can not end with whitespace' }

  has_and_belongs_to_many :games

  def to_param
    handle
  end

  private

    def generate_handle
      self.handle ||= self.username.parameterize if self.username.present?
    end
end
