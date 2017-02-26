class AddGameReleaseReferenceToGameFile < ActiveRecord::Migration[5.0]
  def change
    add_reference :game_files, :game_release, forign_key: true
  end
end
