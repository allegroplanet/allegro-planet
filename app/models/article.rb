class Article < ApplicationRecord
  before_validation :generate_handle

  validates :title,
    presence: true,
    uniqueness: true,
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :only_printable_characters] }
  validates :handle,
    presence: true,
    uniqueness: true,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :only_printable_characters] }
  validates :body_markdown,
    presence: true,
    allow_blank: false,
    string_format: { rules: [:only_printable_characters_and_newlines] }
  validates :published,
    inclusion: { in: [true, false], message: 'must be either true or false' }

  scope :published, -> { where(published: true) }

  def to_param
    handle
  end

  private

  def generate_handle
    self.handle ||= self.title.parameterize if self.title.present?
  end
end
