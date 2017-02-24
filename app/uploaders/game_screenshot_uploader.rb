class GameScreenshotUploader < CarrierWave::Uploader::Base
  def store_dir
    'screenshots'
  end

  def extension_whitelist
    ['jpg', 'jpeg', 'gif', 'png']
  end
end
