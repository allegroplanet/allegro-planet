class GameFile < ApplicationRecord
  mount_uploader :file, GameFileUploader
end
