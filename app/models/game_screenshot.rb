class GameScreenshot < ApplicationRecord
  mount_uploader :image, GameScreenshotUploader

  belongs_to :game

  def feature_public_url
    public_url(image.feature.path)
  end

  def thumb_public_url
    public_url(image.thumb.path)
  end

  def tile_public_url
    public_url(image.tile.path)
  end

  private

  def public_url(image_path)
    "https://#{Figaro.env.aws_allegro_planet_bucket}.s3.amazonaws.com/#{image_path}"
  end
end
