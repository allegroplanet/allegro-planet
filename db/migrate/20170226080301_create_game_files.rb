class CreateGameFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :game_files do |t|
      t.string :file
      t.string :category

      t.timestamps
    end
  end
end
