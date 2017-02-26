class CreateGameReleases < ActiveRecord::Migration[5.0]
  def change
    create_table :game_releases do |t|
      t.string :version_num
      t.text :notes
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
