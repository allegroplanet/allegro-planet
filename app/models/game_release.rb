class GameRelease < ApplicationRecord
  validates :version_num,
    presence: true,
    uniqueness: { scope: :game, message: 'already exists' },
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :has_only_printable_characters] }

  belongs_to :game

  has_many :game_files
end
