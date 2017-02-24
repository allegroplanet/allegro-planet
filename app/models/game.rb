class Game < ApplicationRecord
  validates :title,
    presence: true,
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :has_only_printable_characters] }

  validates :description,
    presence: true,
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :has_only_printable_characters] }
end
