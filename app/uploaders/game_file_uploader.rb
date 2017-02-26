class GameFileUploader < CarrierWave::Uploader::Base
  def store_dir
    'game-files'
  end

  def extension_whitelist
    ['zip', '7z']
  end
end

