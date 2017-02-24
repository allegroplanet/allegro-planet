class CreateGamesUsersJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :games_users, id: false do |t|
      t.integer :game_id
      t.integer :user_id
    end

    add_index :games_users, :game_id
    add_index :games_users, :user_id
  end
end
