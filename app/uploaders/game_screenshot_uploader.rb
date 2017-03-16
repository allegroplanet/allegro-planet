class GameScreenshotUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  VERSION_FEATURE_SIZE = [640, 360] # 1/3 HD
  VERSION_TILE_SIZE    = [320, 180] # 1/6 HD
  VERSION_THUMB_SIZE   = [160, 90]  # 1/12 HD

  def store_dir
    'screenshots'
  end

  version :feature do
    process resize_to_fit: VERSION_FEATURE_SIZE
  end

  version :tile do
    process resize_and_pad: VERSION_TILE_SIZE
  end

  version :thumb do
    process resize_and_pad: VERSION_THUMB_SIZE
  end

  def extension_whitelist
    ['jpg', 'jpeg', 'gif', 'png']
  end
end
