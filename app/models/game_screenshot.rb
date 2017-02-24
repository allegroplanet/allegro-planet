class GameScreenshot < ApplicationRecord
  mount_uploader :image, GameScreenshotUploader

  belongs_to :game
end
