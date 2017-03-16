class GameScreenshot < ApplicationRecord
  mount_uploader :image, GameScreenshotUploader

  belongs_to :game

  private

  def public_url(image_path)
    "https://#{Figaro.env.aws_allegro_planet_bucket}.s3.amazonaws.com/#{image_path}"
  end
end
