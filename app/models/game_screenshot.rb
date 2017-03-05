class GameScreenshot < ApplicationRecord
  mount_uploader :image, GameScreenshotUploader

  belongs_to :game

  def public_url
    "https://#{Figaro.env.aws_allegro_planet_bucket}.s3.amazonaws.com/#{image.path}"
  end
end
