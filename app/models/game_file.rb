class GameFile < ApplicationRecord
  GAME_FILE_CATEGORIES = ['MacOS binary', 'Win binary', 'Linux binary', 'Data files', 'Source files', 'Other'].freeze
  INCLUSION_MESSAGE = "must be one of #{GAME_FILE_CATEGORIES}"

  mount_uploader :file, GameFileUploader

  validates :category,
    presence: { message: INCLUSION_MESSAGE },
    inclusion: { in: GAME_FILE_CATEGORIES, message: INCLUSION_MESSAGE }

  belongs_to :game_release

  def public_url
    "https://#{Figaro.env.aws_allegro_planet_bucket}.s3.amazonaws.com/#{file.path}"
  end
end
