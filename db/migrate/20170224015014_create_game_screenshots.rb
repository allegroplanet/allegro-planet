class CreateGameScreenshots < ActiveRecord::Migration[5.0]
  def change
    create_table :game_screenshots do |t|
      t.string :image
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
