class Game < ApplicationRecord
  before_validation :generate_slug

  validates :title,
    presence: true,
    uniqueness: true,
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :has_only_printable_characters] }

  validates :description,
    presence: true,
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :has_only_printable_characters] }

  validates :slug,
    presence: true,
    uniqueness: true

  has_many :game_screenshots

  has_and_belongs_to_many :users

  private

    def generate_slug
      self.slug ||= self.title.parameterize if self.title.present?
    end
end
