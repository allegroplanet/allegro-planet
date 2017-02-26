class GameFile < ApplicationRecord
  GAME_FILE_CATEGORIES = ['MacOS binary', 'Win binary', 'Linux binary', 'Data file', 'Source files', 'Other'].freeze

  mount_uploader :file, GameFileUploader

  validates :category, inclusion: { in: GAME_FILE_CATEGORIES, message: "\"%{value}\" is not a valid value" }

  belongs_to :game_release
end
