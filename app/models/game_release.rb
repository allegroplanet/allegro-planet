class GameRelease < ApplicationRecord
  belongs_to :game
  has_many :game_files

  validates :version_num,
    presence: true,
    uniqueness: { scope: :game, message: 'already exists' },
    allow_blank: false,
    string_format: { rules: [:starts_with_non_whitespace, :ends_with_non_whitespace, :only_printable_characters] }
end
